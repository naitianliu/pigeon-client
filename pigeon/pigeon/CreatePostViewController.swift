//
//  CreatePostViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/14/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit
import SZTextView

class CreatePostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var textView: SZTextView!
    
    var pickerController:UIImagePickerController!
    
    var imgArray:[UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pickerController = UIImagePickerController()
        pickerController.view.backgroundColor = UIColor.orangeColor()
        var sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        pickerController.sourceType = sourceType
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        self.imgArray = []
        
        self.setupUI(self.imgArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonOnClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

    func setupUI(imgArray:[UIImage]) {
        var number = imgArray.count
        var width:CGFloat = (self.view.frame.width - 32) / 3
        println(width)
        var firstX:CGFloat = self.textView.frame.origin.x
        var firstY:CGFloat = self.textView.frame.origin.y + self.textView.frame.height
        for (var i=0; i<number; i++) {
            var factor:Int = number / 3
            var mod:Int = number % 3
            var img:UIImage = imgArray[i]
            var imgView:UIImageView = UIImageView(frame: CGRect(x: firstX + CGFloat(mod) * width, y: firstY + width * CGFloat(factor), width: width, height: width))
            imgView.image = img
            self.view.addSubview(imgView)
        }
        var factor:Int = number / 3
        var mod:Int = number % 3
        println("\(factor)  \(mod)")
        var button:UIButton = UIButton.buttonWithType(UIButtonType.ContactAdd) as! UIButton
        button.frame = CGRect(x: firstX + CGFloat(mod) * width, y: firstY + width * CGFloat(factor), width: width, height: width)
        button.layer.borderColor = UIColor.grayColor().CGColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: Selector("addImgButtonOnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        println(button.frame.width)
        self.view.addSubview(button)
    }
    
    func addImgButtonOnClick(sender:UIButton!) {
        
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var img:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        self.imgArray.append(img)
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.setupUI(self.imgArray)
        })
    }

}
