//
//  CreatePostViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/14/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit
import SZTextView
import AWSS3

class CreatePostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var textView: SZTextView!
    
    var pickerController:UIImagePickerController!
    
    var imgArray:[UIImage]!
    
    var imgEditView:UIView = UIView()
    
    var uploadRequests = Array<AWSS3TransferManagerUploadRequest?>()
    var uploadFileURLs = Array<NSURL?>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var error = NSErrorPointer()
        if !NSFileManager.defaultManager().createDirectoryAtPath(
            NSTemporaryDirectory().stringByAppendingPathComponent("upload"),
            withIntermediateDirectories: true,
            attributes: nil,
            error: error) {
                println("Creating 'upload' directory failed. Error: \(error)")
        }
        
        pickerController = UIImagePickerController()
        pickerController.view.backgroundColor = UIColor.orangeColor()
        var sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        pickerController.sourceType = sourceType
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        self.view.addSubview(self.imgEditView)
        self.imgArray = []
        
        self.setupUI(self.imgArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendButtonOnClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            var imgUrls:[String] = []
            for image in self.imgArray {
                let fileName = NSProcessInfo.processInfo().globallyUniqueString.stringByAppendingString(".png")
                let filePath = NSTemporaryDirectory().stringByAppendingPathComponent("upload").stringByAppendingPathComponent(fileName)
                let imageData = UIImagePNGRepresentation(image)
                imageData.writeToFile(filePath, atomically: true)
                
                let uploadRequest = AWSS3TransferManagerUploadRequest()
                uploadRequest.body = NSURL(fileURLWithPath: filePath)
                uploadRequest.key = fileName
                uploadRequest.bucket = const_S3BucketName
                println(fileName)
                self.uploadRequests.append(uploadRequest)
                self.uploadFileURLs.append(nil)
                self.upload(uploadRequest)
                imgUrls.append(const_S3URL + fileName)
            }
        })
    }
    
    @IBAction func cancelButtonOnClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

    func setupUI(imgArray:[UIImage]) {
        for view in self.imgEditView.subviews {
            view.removeFromSuperview()
        }
        var number = imgArray.count
        var width:CGFloat = (self.view.frame.width - 32) / 3
        println(width)
        var firstX:CGFloat = self.textView.frame.origin.x
        var firstY:CGFloat = self.textView.frame.origin.y + self.textView.frame.height
        var factor:Int = number / 3
        var mod:Int = number % 3
        self.imgEditView.frame = CGRect(x: firstX, y: firstY, width: self.view.frame.width - 32, height: CGFloat(factor+1) * width)
        for (var i=0; i<number; i++) {
            var ifactor:Int = i / 3
            var imod:Int = i % 3
            var img:UIImage = imgArray[i]
            var imgView:UIImageView = UIImageView(frame: CGRect(x: CGFloat(imod) * width, y: width * CGFloat(ifactor), width: width, height: width))
            imgView.image = img
            self.imgEditView.addSubview(imgView)
        }
        
        println("\(factor)  \(mod)")
        var button:UIButton = UIButton.buttonWithType(UIButtonType.ContactAdd) as! UIButton
        button.frame = CGRect(x: CGFloat(mod) * width, y: width * CGFloat(factor), width: width, height: width)
        button.layer.borderColor = UIColor.grayColor().CGColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: Selector("addImgButtonOnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        println(button.frame.width)
        self.imgEditView.addSubview(button)
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
    
    func upload(uploadRequest: AWSS3TransferManagerUploadRequest) {
        let transferManager = AWSS3TransferManager.defaultS3TransferManager()
        
        transferManager.upload(uploadRequest).continueWithBlock { (task) -> AnyObject! in
            if let error = task.error {
                if error.domain == AWSS3TransferManagerErrorDomain as String {
                    if let errorCode = AWSS3TransferManagerErrorType(rawValue: error.code) {
                        switch (errorCode) {
                        case .Cancelled, .Paused:
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in

                            })
                            break;
                            
                        default:
                            println("upload() failed: [\(error)]")
                            break;
                        }
                    } else {
                        println("upload() failed: [\(error)]")
                    }
                } else {
                    println("upload() failed: [\(error)]")
                }
            }
            
            if let exception = task.exception {
                println("upload() failed: [\(exception)]")
            }
            
            if task.result != nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if let index = self.indexOfUploadRequest(self.uploadRequests, uploadRequest: uploadRequest) {
                        self.uploadRequests[index] = nil
                        self.uploadFileURLs[index] = uploadRequest.body
                        let indexPath = NSIndexPath(forRow: index, inSection: 0)
                    }
                })
            }
            return nil
        }
    }
    
    func indexOfUploadRequest(array: Array<AWSS3TransferManagerUploadRequest?>, uploadRequest: AWSS3TransferManagerUploadRequest?) -> Int? {
        for (index, object) in enumerate(array) {
            if object == uploadRequest {
                return index
            }
        }
        return nil
    }

    

}
