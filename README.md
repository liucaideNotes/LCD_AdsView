# LCD_AdsView
广告轮播View，基于CollectionView

![image description](adsView.gif)


    /*
     * view 父view
     * adsType 轮播图样式
     * imageUrls 图片数组
     * isUrlImage 是否为网络图片，默认为网络图片，
     * itemSize cell 大小
     */
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
