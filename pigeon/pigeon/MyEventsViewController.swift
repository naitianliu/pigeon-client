//
//  MyEventsViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 9/3/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit

class MyEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let myProfileURL:String = "http://tp3.sinaimg.cn/2525851962/180/40000907046/1"

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println(self.tableView.backgroundColor)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /*
        var cell = tableView.dequeueReusableCellWithIdentifier("MyEventCell", forIndexPath: indexPath) as? UITableViewCell
        
        if cell == nil {
            print("cell null")
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MyEventCell")
        }*/
        
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "MyEventCell")
        
        cell.contentView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 150)
        
        var renderCellHelper = RenderEventCellHelper(cell: cell)
        renderCellHelper.setLatestMessage("刘乃天", editorImgUrl: myProfileURL, message: "明天一起去吃饭吧！", time: "9:30 上午")
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

}
