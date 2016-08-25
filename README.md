# LCD_AdsView
广告轮播View，基于CollectionView
![image description](adsView.gif)

            let cell = TableViewCell_Title.dequeueReusable(tableView, indexPath:indexPath)
            let adsView = LCDAdsView.show(cell.contentView, frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, cell_H), adsType: .Default_H, imageUrls: images1, time: Double(indexPath.section))
            cell.titleLab.text = "title_\(0)"
            adsView._LCDAdsViewClosures = { (itemIdex, isSelect) in
                if isSelect {
                    let aler = UIAlertController(title: "点击了第\(itemIdex)张图片", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    let one = UIAlertAction.init(title: "确定", style: .Default, handler: { (UIAlertAction) in
                    })
                    aler.addAction(one)
                    self.presentViewController(aler, animated: true, completion: nil)
                }else{
                    //可以在这里对自定义分页圆点或其他控件赋值
                    
                    cell.titleLab.text = "title_\(itemIdex)"
                }
            }
            cell.contentView.sendSubviewToBack(adsView)
            return cell
