//
//  ZWWaterfallLayout.swift
//  WaterfallLayout
//
//  Created by zhangwei on 16/12/16.
//  Copyright © 2016年 jyall. All rights reserved.
//

import UIKit

protocol  ZWWaterfallLayoutDelegate:class {
    func numberOfCols(_ waterfall : ZWWaterfallLayout) -> Int
    func waterfall(_ waterfall : ZWWaterfallLayout, item : Int) -> CGFloat
}

class ZWWaterfallLayout: UICollectionViewFlowLayout {
    
    weak var dataSource : ZWWaterfallLayoutDelegate?
    fileprivate lazy var cellAttrs : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    fileprivate lazy var cols :Int = {
    return self.dataSource?.numberOfCols(self) ?? 2
    }()
    fileprivate lazy var totalHeights :[CGFloat] = Array(repeating: self.sectionInset.top, count: self.cols)
}


extension ZWWaterfallLayout{
    override func prepare() {
        super.prepare()
        
        //1.获取cell的个数
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        //2.重新布局
        
        let cellW:CGFloat = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - CGFloat(cols - 1) * minimumInteritemSpacing)/CGFloat(cols)
        
        for i in 0..<itemCount {
             // 1.根据i创建indexPath
            let indexPath = IndexPath(item: i, section: 0)
             // 2.根据indexPath创建对应的UICollectionViewLayoutAttributes
            let arr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 3.设置attr中的frame
            guard let cellH : CGFloat = dataSource?.waterfall(self, item: i) else{
              fatalError("请实现对应的数据源方法,并且返回Cell高度")
            }
            let minH = totalHeights.min()!
            
            
            let minIndex = totalHeights.index(of: minH)!

           let cellX : CGFloat = sectionInset.left + (cellW + minimumInteritemSpacing) * CGFloat(minIndex)

            let cellY : CGFloat = minH;
            
            
            arr.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
            // 4 保存 arr
            cellAttrs.append(arr)
            //添加当前的高度
            totalHeights[minIndex] = minH + minimumLineSpacing + cellH
            
        }
        
    }

}

extension ZWWaterfallLayout{
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttrs
    }
    

}

extension ZWWaterfallLayout{
    override var collectionViewContentSize: CGSize{
        return CGSize(width: 0, height: totalHeights.max()! + sectionInset.bottom  - minimumLineSpacing)
    }
}
