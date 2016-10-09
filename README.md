# LCD_AdsView
广告轮播View，基于CollectionView

![image description](ads.gif)

```
/**
* 需要必要的第三方库 SDWebImage 的支持
* 必要的默认图片修改 LCD_AdsView.placeholderImage = ""
* 参数列表：
* view 父view 必要
* imageUrls 图片数组 必要
* isUrlImage 是否为网络图片，默认为网络图片， 非必要，默认true
* time 时间间隔  非必要，默认5.0秒
* adsType 轮播图样式 非必要，默认 .default_H
* itemSize cell 大小 非必要，默认CGSize(width:frame.size.width/2, height:frame.size.height/2)
* pageAlignment 分页圆点的位置 非必要，默认 居中

* 使用只需要执行 LCD_AdsView.show()
*/

            let cell = TableViewCell_Title.dequeueReusable(tableView: tableView, indexPath:indexPath as IndexPath)
            let adsView = LCD_AdsView.show(view: cell.contentView, frame: CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:cell_H), imageUrls: images1, time: Double(indexPath.section), adsType: .default_H)
            cell.titleLab.text = "title_\(_itemIdex)"
            adsView.LCD_AdsViewClosures = { (itemIdex, isSelect) in
                if isSelect {
                    let aler = UIAlertController(title: "点击了第\(itemIdex)张图片", message: nil, preferredStyle: .alert)
                    let one = UIAlertAction.init(title: "确定", style: .default, handler: { (UIAlertAction) in
                    })
                    aler.addAction(one)
                    self.present(aler, animated: true, completion: nil)
                }else{
                    //可以在这里对自定义分页圆点或其他空间赋值
                    self._itemIdex = itemIdex
//                    let dic:[String:Any] = ["2":123,"3":"456"]
//                    cell.titleLab.text = dic["1"]! as? String
                    cell.titleLab.text = "title_\(itemIdex)"
                }
            }
            cell.contentView.sendSubview(toBack: adsView)//将轮播放在底层
            
            return cell
