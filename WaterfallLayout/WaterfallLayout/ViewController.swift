//
//  ViewController.swift
//  WaterfallLayout
//
//  Created by zhangwei on 16/12/16.
//  Copyright © 2016年 jyall. All rights reserved.
//

import UIKit

private let KContentCellID = "KContentCellID"

class ViewController: UIViewController {
    
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = ZWWaterfallLayout()
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.dataSource = self
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        
        return collectionView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    view.addSubview(collectionView)
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KContentCellID)
    collectionView.backgroundColor = UIColor.gray
    }


    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : ZWWaterfallLayoutDelegate{
    func numberOfCols(_ waterfall: ZWWaterfallLayout) -> Int {
        return 3
    }
    func waterfall(_ waterfall: ZWWaterfallLayout, item: Int) -> CGFloat {
        return CGFloat(arc4random_uniform(150) + 100)
    }
    

}

extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 400
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KContentCellID, for: indexPath)
        cell.backgroundColor = UIColor.red
        
        return cell
    }

}
