//
//  CreatePostViewHelper.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/14/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import Foundation
import SZTextView

class CreatePostViewHelper: NSObject {
    
    var view:UIView!
    var textView:SZTextView!
    var textViewRect:CGRect!
    
    init(view:UIView, textView:SZTextView) {
        self.view = view
        self.textView = textView
        self.textViewRect = self.textView.frame
    }
    
}