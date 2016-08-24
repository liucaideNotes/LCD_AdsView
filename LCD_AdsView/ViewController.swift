//
//  ViewController.swift
//  LCD_AdsView
//
//  Created by 刘才德 on 16/8/21.
//  Copyright © 2016年 sifenzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let images1 = ["http://p1.ifengimg.com/a/2016_35/bf489286fc9050d_size52_w900_h502.jpg",
                   "http://p0.ifengimg.com/a/2016_35/becb7b6d997a1d0_size53_w750_h500.jpg",
                   "http://p1.ifengimg.com/a/2016_35/dc2acc684d61c74_size57_w978_h550.jpg",
                   "http://p2.ifengimg.com/a/2016_35/f966a4d9e469952_size57_w978_h550.jpg",
                   "http://p0.ifengimg.com/a/2016_35/071b8b8c35a9a9e_size39_w750_h500.jpg",
                   "",
                   "http://p1.ifengimg.com/a/2016_35/0eac1e14cbb655e_size49_w750_h480.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    let cell_H:CGFloat = 150.0
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cell_H
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cellID_null = "Cell_00"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID_null)
            if (cell == nil)
            {
                cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellID_null)
            }
            let adsView = LCDAdsView.show(cell!.contentView, frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, cell_H), adsType: .Default_H, imageUrls: images1)
            adsView._LCDAdsViewClosures = { (itemIdex, isSelect) in
            }
            return cell!
        case 1:
            let cell = TableViewCell_Title.dequeueReusable(tableView, indexPath:indexPath)
            let adsView = LCDAdsView.show(cell.contentView, frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, cell_H), adsType: .Default_H, imageUrls: images1, time: Double(indexPath.section))
            cell.titleLab.text = "title_\(0)"
            adsView._LCDAdsViewClosures = { (itemIdex, isSelect) in
                if isSelect {
                    
                }else{
                    cell.titleLab.text = "title_\(itemIdex)"
                }
            }
            cell.contentView.sendSubviewToBack(adsView)
            return cell
        case 2:
            let cellID_null = "Cell_02"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID_null)
            if (cell == nil)
            {
                cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellID_null)
            }
            let adsView = LCDAdsView.show(cell!.contentView, frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, cell_H), adsType: .Half_H, imageUrls: images1,time: Double(indexPath.section),itemSize:CGSizeMake(UIScreen.mainScreen().bounds.size.width/2 - 2, cell_H))
            adsView._LCDAdsViewClosures = { (itemIdex, isSelect) in
            }
            return cell!
        default:
            let cellID_null = "Cell_0\(indexPath.section)"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID_null)
            if (cell == nil)
            {
                cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellID_null)
            }
            let adsView = LCDAdsView.show(cell!.contentView, frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, cell_H), adsType: .Default_H, imageUrls: images1, time: Double(indexPath.section))
            adsView._LCDAdsViewClosures = { (itemIdex, isSelect) in
            }
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let array =  tableView.indexPathsForVisibleRows
        let firstIndexPath = array![0]
        //设置anchorPoint
        cell.layer.anchorPoint = CGPointMake(0, 0.5)
        //为了防止cell视图移动，重新把cell放回原来的位置
        cell.layer.position = CGPointMake(0, cell.layer.position.y)
        
        
        //设置cell 按照z轴旋转90度，注意是弧度
        if (firstIndexPath.row < indexPath.row) {
            cell.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0, 0, 1.0)
        }else{
            cell.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 0, 0, 1.0)
        }
        
        
        cell.alpha = 0.0;
        UIView.animateWithDuration(1.0, animations: { 
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
            }) { (Bool) in
                
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

