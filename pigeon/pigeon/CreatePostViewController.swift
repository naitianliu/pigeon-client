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

class CreatePostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, APIEventHelperDelegate {

    let apiUrl:String = "\(const_APIEndpoint)/main/create_new_post/"
    
    @IBOutlet weak var textView: SZTextView!
    
    var pickerController:UIImagePickerController!
    
    var eventId:String = ""
    
    var imgArray:[UIImage]!
    
    var imgEditView:UIView = UIView()
    
    var uploadRequests = Array<AWSS3TransferManagerUploadRequest?>()
    var uploadFileURLs = Array<NSURL?>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        do {
            try NSFileManager.defaultManager().createDirectoryAtURL(NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent("upload"), withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Creating 'upload' directory failed. Error: \(error)")
        }
        
        pickerController = UIImagePickerController()
        pickerController.view.backgroundColor = UIColor.orangeColor()
        let sourceType = UIImagePickerControllerSourceType.PhotoLibrary
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
    
    func beforeSendRequest() {
        
    }
    
    func afterReceiveResponse(responseData: AnyObject) {
        
    }
    
    @IBAction func sendButtonOnClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            var imgUrls:[String] = []
            for image in self.imgArray {
                let fileName = NSProcessInfo.processInfo().globallyUniqueString.stringByAppendingString(".png")
                // let filePath = NSTemporaryDirectory().stringByAppendingPathComponent("upload").stringByAppendingPathComponent(fileName)
                let filePath = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent("upload").URLByAppendingPathComponent(fileName)
                print(filePath)
                let imageData = UIImagePNGRepresentation(image)
                imageData!.writeToURL(filePath, atomically: true)
                
                let uploadRequest = AWSS3TransferManagerUploadRequest()
                uploadRequest.ACL = AWSS3ObjectCannedACL.PublicRead
                uploadRequest.body = filePath
                uploadRequest.key = fileName
                uploadRequest.bucket = const_S3BucketName
                print(fileName)
                self.uploadRequests.append(uploadRequest)
                self.uploadFileURLs.append(nil)
                self.upload(uploadRequest)
                imgUrls.append(const_S3URL + fileName)
            }
            let event_id = ""
            let description = self.textView.text
            var requestData:[String: AnyObject] = [:]
            requestData["event_id"] = event_id
            requestData["description"] = description
            requestData["img_urls"] = imgUrls
            APIEventHelper(url: self.apiUrl, data: requestData, delegate: self).POST()
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
        let number = imgArray.count
        let width:CGFloat = (self.view.frame.width - 32) / 3
        print(width)
        let firstX:CGFloat = self.textView.frame.origin.x
        let firstY:CGFloat = self.textView.frame.origin.y + self.textView.frame.height
        let factor:Int = number / 3
        let mod:Int = number % 3
        self.imgEditView.frame = CGRect(x: firstX, y: firstY, width: self.view.frame.width - 32, height: CGFloat(factor+1) * width)
        for (var i=0; i<number; i++) {
            let ifactor:Int = i / 3
            let imod:Int = i % 3
            let img:UIImage = imgArray[i]
            let imgView:UIImageView = UIImageView(frame: CGRect(x: CGFloat(imod) * width, y: width * CGFloat(ifactor), width: width, height: width))
            imgView.image = img
            self.imgEditView.addSubview(imgView)
        }
        
        print("\(factor)  \(mod)")
        let button:UIButton = UIButton(type: UIButtonType.ContactAdd)
        button.frame = CGRect(x: CGFloat(mod) * width, y: width * CGFloat(factor), width: width, height: width)
        button.layer.borderColor = UIColor.grayColor().CGColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: Selector("addImgButtonOnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        print(button.frame.width)
        self.imgEditView.addSubview(button)
    }
    
    func addImgButtonOnClick(sender:UIButton!) {
        
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let img:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
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
                            print("upload() failed: [\(error)]")
                            break;
                        }
                    } else {
                        print("upload() failed: [\(error)]")
                    }
                } else {
                    print("upload() failed: [\(error)]")
                }
            }
            
            if let exception = task.exception {
                print("upload() failed: [\(exception)]")
            }
            
            if task.result != nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if let index = self.indexOfUploadRequest(self.uploadRequests, uploadRequest: uploadRequest) {
                        self.uploadRequests[index] = nil
                        self.uploadFileURLs[index] = uploadRequest.body
                        let indexPath = NSIndexPath(forRow: index, inSection: 0)
                        print(indexPath)
                    }
                })
            }
            return nil
        }
    }
    
    func indexOfUploadRequest(array: Array<AWSS3TransferManagerUploadRequest?>, uploadRequest: AWSS3TransferManagerUploadRequest?) -> Int? {
        for (index, object) in array.enumerate() {
            if object == uploadRequest {
                return index
            }
        }
        return nil
    }

    

}
