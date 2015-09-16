//
//  GroupViewHelper.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/1/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import Foundation

class GroupCell: UICollectionViewCell {
    var textLabel:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        self.addSubview(self.textLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GroupViewHelper: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var rootViewController:UIViewController!
    var groupView:UIView!
    var collectionView:UICollectionView!
    
    init(rootViewController:UIViewController, groupView:UIView) {
        super.init()
        
        self.rootViewController = rootViewController
        self.groupView = groupView
        // var flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        // flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        self.collectionView = UICollectionView(frame: self.groupView.frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        // self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "GroupCollectionCell")
        self.groupView.addSubview(self.collectionView)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("GroupCollectionCell", forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}