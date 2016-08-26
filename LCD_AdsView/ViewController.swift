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
    
    var images1 = ["http://p1.ifengimg.com/a/2016_35/bf489286fc9050d_size52_w900_h502.jpg",
                   "placeholderImage",
                   "http://p0.ifengimg.com/a/2016_35/becb7b6d997a1d0_size53_w750_h500.jpg",
                   "http://p1.ifengimg.com/a/2016_35/dc2acc684d61c74_size57_w978_h550.jpg",
                   "http://p2.ifengimg.com/a/2016_35/f966a4d9e469952_size57_w978_h550.jpg",
                   "http://p0.ifengimg.com/a/2016_35/071b8b8c35a9a9e_size39_w750_h500.jpg",
                   "http://p1.ifengimg.com/a/2016_35/0eac1e14cbb655e_size49_w750_h480.jpg",
                   "http://photocdn.sohu.com/20160824/Img465700296.jpg",
                   "http://photocdn.sohu.com/20160825/Img465897773.jpg",
                   "http://photocdn.sohu.com/20160825/Img465875448.jpg",
                   "http://photocdn.sohu.com/20160825/Img465875443.jpg",
                   "http://photocdn.sohu.com/20160825/Img465875446.jpg",
                   "http://photocdn.sohu.com/20160825/Img465875449.jpg",
                   "http://photocdn.sohu.com/20160825/Img465875450.jpg",
                   "http://photocdn.sohu.com/20160825/Img465875451.jpg",
                   "http://photocdn.sohu.com/20160825/Img465875452.jpg",
                   "http://photocdn.sohu.com/20160825/Img465875453.jpg"
                   ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.performSelector(#selector(ViewController.upArrayClick), withObject: nil, afterDelay: 4.3)
    }
    
    func upArrayClick() {
        images1.removeLast()
        tableView.reloadData()
        if images1.count > 0 {
            self.performSelector(#selector(ViewController.upArrayClick), withObject: nil, afterDelay: 4.3)
        }
        
    }
    
    
    
    
    let cell_H:CGFloat = 150.0
    var _itemIdex = 0
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "第\(section)组"
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cell_H
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cellID_null = "Cell_0\(indexPath.section)"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID_null)
            if (cell == nil)
            {
                cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellID_null)
            }
            let adsView = LCDAdsView.show(cell!.contentView, frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, cell_H), adsType: .Default_H, imageUrls: images1)
            adsView._LCDAdsViewClosures = { (itemIdex, isSelect) in
                if isSelect {
                    let aler = UIAlertController(title: "点击了第\(itemIdex)张图片", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    let one = UIAlertAction.init(title: "确定", style: .Default, handler: { (UIAlertAction) in
                    })
                    aler.addAction(one)
                    self.presentViewController(aler, animated: true, completion: nil)
                }
            }
            return cell!
        case 1:
            let cell = TableViewCell_Title.dequeueReusable(tableView, indexPath:indexPath)
            let adsView = LCDAdsView.show(cell.contentView, frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, cell_H), adsType: .Default_H, imageUrls: images1, time: Double(indexPath.section))
            cell.titleLab.text = "title_\(_itemIdex)"
            adsView._LCDAdsViewClosures = { (itemIdex, isSelect) in
                if isSelect {
                    let aler = UIAlertController(title: "点击了第\(itemIdex)张图片", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    let one = UIAlertAction.init(title: "确定", style: .Default, handler: { (UIAlertAction) in
                    })
                    aler.addAction(one)
                    self.presentViewController(aler, animated: true, completion: nil)
                }else{
                    //可以在这里对自定义分页圆点或其他空间赋值
                    self._itemIdex = itemIdex
                    cell.titleLab.text = "title_\(itemIdex)"
                }
            }
            cell.contentView.sendSubviewToBack(adsView)//将轮播放在底层
            return cell
        case 2:
            let cellID_null = "Cell_0\(indexPath.section)"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID_null)
            if (cell == nil)
            {
                cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellID_null)
            }
            let adsView = LCDAdsView.show(cell!.contentView, frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, cell_H), adsType: .Half_H, imageUrls: images1,itemSize:CGSizeMake(UIScreen.mainScreen().bounds.size.width/2 - 2, cell_H))
            adsView._LCDAdsViewClosures = { (itemIdex, isSelect) in
                if isSelect {
                    let aler = UIAlertController(title: "点击了第\(itemIdex)张图片", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    let one = UIAlertAction.init(title: "确定", style: .Default, handler: { (UIAlertAction) in
                    })
                    aler.addAction(one)
                    self.presentViewController(aler, animated: true, completion: nil)
                }
            }
            return cell!
        case 3:
            let cellID_null = "Cell_0\(indexPath.section)"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID_null)
            if (cell == nil)
            {
                cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellID_null)
            }
            let adsView = LCDAdsView.show(cell!.contentView, frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, cell_H), adsType: .ImageBrowse_H, imageUrls: images1,itemSize:CGSizeMake((cell_H-5)/2, (cell_H-5)/2))
            adsView._LCDAdsViewClosures = { (itemIdex, isSelect) in
                if isSelect {
                    let aler = UIAlertController(title: "点击了第\(itemIdex)张图片", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    let one = UIAlertAction.init(title: "确定", style: .Default, handler: { (UIAlertAction) in
                    })
                    aler.addAction(one)
                    self.presentViewController(aler, animated: true, completion: nil)
                }
            }
            return cell!
        case 4:
            let cellID_null = "Cell_0\(indexPath.section)"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID_null)
            if (cell == nil)
            {
                cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellID_null)
            }
            let adsView = LCDAdsView.show(cell!.contentView, frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, cell_H), adsType: .ImageBrowse_V, imageUrls: images1)
            adsView._LCDAdsViewClosures = { (itemIdex, isSelect) in
                if isSelect {
                    let aler = UIAlertController(title: "点击了第\(itemIdex)张图片", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    let one = UIAlertAction.init(title: "确定", style: .Default, handler: { (UIAlertAction) in
                    })
                    aler.addAction(one)
                    self.presentViewController(aler, animated: true, completion: nil)
                }
            }
            return cell!
        case 5:
            let cellID_null = "Cell_0\(indexPath.section)"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID_null)
            if (cell == nil)
            {
                cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellID_null)
            }
            let adsView = LCDAdsView.show(cell!.contentView, frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, cell_H), adsType: .ImageBrowse_V, imageUrls: [],itemSize:CGSizeMake((cell_H-5)/2, (cell_H-5)/2))
            adsView._LCDAdsViewClosures = { (itemIdex, isSelect) in
                if isSelect {
                    let aler = UIAlertController(title: "点击了第\(itemIdex)张图片", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    let one = UIAlertAction.init(title: "确定", style: .Default, handler: { (UIAlertAction) in
                    })
                    aler.addAction(one)
                    self.presentViewController(aler, animated: true, completion: nil)
                }
            }
            return cell!
        default:
            let cellID_null = "Cell_0\(indexPath.section)"
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID_null)
            if (cell == nil)
            {
                cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellID_null)
            }
            let adsView = LCDAdsView.show(cell!.contentView, frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, cell_H), adsType: .Default_H, imageUrls: images1)
            adsView._LCDAdsViewClosures = { (itemIdex, isSelect) in
                if isSelect {
                    let aler = UIAlertController(title: "点击了第\(itemIdex)张图片", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    let one = UIAlertAction.init(title: "确定", style: .Default, handler: { (UIAlertAction) in
                    })
                    aler.addAction(one)
                    self.presentViewController(aler, animated: true, completion: nil)
                }
            }
            return cell!
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        let array =  tableView.indexPathsForVisibleRows
//        let firstIndexPath = array![0]
//        //设置anchorPoint
//        cell.layer.anchorPoint = CGPointMake(0, 0.5)
//        //为了防止cell视图移动，重新把cell放回原来的位置
//        cell.layer.position = CGPointMake(0, cell.layer.position.y)
//        
//        
//        //设置cell 按照z轴旋转90度，注意是弧度
//        if (firstIndexPath.row < indexPath.row) {
//            cell.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 0, 0, 1.0)
//        }else{
//            cell.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 0, 0, 1.0)
//        }
//        
//        
//        cell.alpha = 0.0;
//        UIView.animateWithDuration(1.0, animations: { 
//            cell.layer.transform = CATransform3DIdentity
//            cell.alpha = 1.0
//            }) { (Bool) in
//                
//        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

