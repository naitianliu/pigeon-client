//
//  GroupContactViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/21/15.
//  Copyright © 2015 naitianliu. All rights reserved.
//

import UIKit

class GroupContactViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionView:UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionViewFrame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 64 - 46 - 50)
        self.collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: UICollectionViewFlowLayout())
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "GroupCollectionCell")
        self.view.addSubview(self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("GroupCollectionCell", forIndexPath: indexPath)
        let imageView:UIImageView = UIImageView(image: UIImage(named: "close"))
        imageView.frame = CGRect(x: 5, y: 5, width: 100, height: 100)
        cell.sizeToFit()
        let outerRect:CGRect = cell.contentView.frame
        let innerView:UIView = UIView(frame: CGRect(x: 7, y: 7, width: outerRect.width - 10, height: outerRect.width - 10))
        innerView.layer.borderWidth = 0.5
        innerView.layer.borderColor = UIColor.grayColor().CGColor
        innerView.addSubview(imageView)
        cell.contentView.addSubview(innerView)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2 - 5, height: self.view.frame.width/2 - 5)
    }


}
