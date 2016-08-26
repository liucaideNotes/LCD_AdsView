//
//  LCDAdsView.swift
//  iexbuy
//
//  Created by sifenzi on 16/5/18.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//

import UIKit
import SDWebImage

public enum LCDAdsViewType {
    case Default_H
    case Half_H
    case ImageBrowse_H
    case ImageBrowse_V
    
}
class LCDAdsView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    ///闭包传值
    var _LCDAdsViewClosures: ((itemIdex: Int, isSelect:Bool) -> Void)?
    ///collectionView
    var collectionView: UICollectionView!
    ///分页圆点
    var scrollPageControl = UIPageControl()
    ///图片数据
    var _imageUrls:[String] = [] {
        didSet{
            xzSetType()
            
            
            
            if _imageUrls.count == 0 {
                _imageView.hidden = false //显示底图
            }else{
                _imageView.hidden = true  //隐藏底图
            }
        }
        
    }
    
    private var _layout = UICollectionViewFlowLayout()
    private var _adsType: LCDAdsViewType = .Default_H
    private var _imaCount:Int = 0
    private var _time = 5.0
    private var _frame = CGRectZero
    private var _sendTime: NSTimer!
    private var _imageView = UIImageView()
    private var  itemIdex: Int = 0
    private var _isUrlImage = true //是否为网络图片
    private var _itemSize:CGSize {
        didSet{
            collectionView.reloadData()
        }
    }
    
    private init(frame: CGRect,adsType:LCDAdsViewType, time: NSTimeInterval) {
        _itemSize = CGSizeMake(frame.size.width, frame.size.height)
        super.init(frame: frame)
        
        _adsType = adsType
        _time = time
        
        ///设置一张底图
        _imageView = UIImageView(frame: frame)
        self.addSubview(_imageView)
        _imageView.image = UIImage(named: "placeholderImage")
        
        
        setCollectionView()
        setScrollPageControl()
        if adsType == .Default_H || adsType == .Half_H {
            updateCollection()
        }
    }
    private func setCollectionView() {
        collectionView =  UICollectionView(frame:frame, collectionViewLayout: _layout)
        collectionView.backgroundColor = UIColor.clearColor()
        
        collectionView.dataSource  = self
        collectionView.delegate = self
        addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator   = false  //隐藏滑动条
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.registerNib(UINib(nibName: "LCDAdsColleCell", bundle: nil), forCellWithReuseIdentifier: "LCDAdsColleCell")
        
    }
    //MARK:----------- 更新数据
    private func xzSetType() {
        _imaCount = _imageUrls.count * 100
        //已滚动后刷新数据不回到原点
        if itemIdex > _imaCount {
            itemIdex = _imaCount/2
        }
        //时间
        if _imageUrls.count < 2 && _sendTime != nil {
            _sendTime.invalidate()
            _sendTime = nil
        }
        if _adsType == .ImageBrowse_H || _adsType == .ImageBrowse_V {
            _imaCount = _imageUrls.count
            itemIdex = 0
        }
        scrollPageControl.numberOfPages = _imageUrls.count // 页数
        // --- 分页圆点
        if _imageUrls.count > 1 {
            scrollPageControl.hidden = false
        }else{
            scrollPageControl.hidden = true
        }
        
        if _adsType == .Default_H && _imageUrls.count > 1 {
            collectionView.pagingEnabled = true //分页显示
            collectionView.bounces = false     // 关闭弹簧
            _layout.scrollDirection = .Horizontal
        }
        if _adsType == .Half_H && _imageUrls.count > 1 {
            _layout.scrollDirection = .Horizontal
            scrollPageControl.hidden = true
        }
        if _adsType == .ImageBrowse_H  {
            _layout.scrollDirection = .Horizontal
            scrollPageControl.hidden = true
        }
        if _adsType == .ImageBrowse_V {
            _layout.scrollDirection = .Vertical
            scrollPageControl.hidden = true
        }
        
        collectionView.reloadData()
        
        if _imaCount > 0 && itemIdex < _imaCount {
            let indexPath = NSIndexPath(forRow: itemIdex, inSection: 0) // 从中间开始
            self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
            
            changePageValue()
        }
        
    
    }
    
    
    
    //MARK:---------- 设置分页圆点
    private func setScrollPageControl() {
        scrollPageControl = UIPageControl.init(frame: CGRectMake(10, frame.size.height - 20, frame.size.width - 20, 20))
        //圆点颜色
        scrollPageControl.pageIndicatorTintColor = UIColor.xzTintColor2()
        scrollPageControl.currentPageIndicatorTintColor = UIColor.xzTintColor1()
        scrollPageControl.enabled = false
        self.addSubview(scrollPageControl)
    }
    //MARK:---------- 改变分页圆点
    private func changePageValue() {
        scrollPageControl.currentPage = itemIdex % _imageUrls.count
        self._LCDAdsViewClosures?(itemIdex:itemIdex % self._imageUrls.count, isSelect:false)
    }
    
    //MARK:---------- 轮循 更新 item
    func updateCollection()  {
        if _time > 0 {
            _sendTime = NSTimer.LCD_scheduledTimerWithTimeInterval(self._time, closure: {
                
                //滚动到某一个 item
                if self._adsType == .Default_H {
                    let indexPath = NSIndexPath(forRow: self.itemIdex, inSection: 0)
                    
                    if self.itemIdex == self._imaCount/2 {
                        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
                    }else{
                        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
                    }
                    self.changePageValue()
                    
                    self.itemIdex += 1
                    if self.itemIdex > self._imaCount - 1{
                        self.itemIdex = self._imaCount/2
                    }
                }
                if self._adsType == .Half_H {
                    let indexPath = NSIndexPath(forRow: self.itemIdex, inSection: 0)
                    if self.itemIdex == self._imaCount/2 {
                        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.Left, animated: false)
                    }else{
                        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
                    }
                    self.changePageValue()
                    
                    self.itemIdex += 1
                    if self.itemIdex > self._imaCount - 1{
                        self.itemIdex = self._imaCount/2
                    }
                }
                
                
                }, repeats: true)
            
            
        }
        
    }
    
    //MARK:---------- UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return _imaCount
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LCDAdsColleCell", forIndexPath: indexPath) as! LCDAdsColleCell
        
        switch _adsType {
        case .Default_H,.Half_H:
            cell.model(_imageUrls[indexPath.item % _imageUrls.count], isUrlImage:_isUrlImage)
        default:
            cell.model(_imageUrls[indexPath.item % _imageUrls.count], isUrlImage:_isUrlImage)
        }
        cell.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        _LCDAdsViewClosures?(itemIdex:indexPath.item % _imageUrls.count, isSelect:true)
    }
    //开始拖曳
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if (_adsType == .Default_H || _adsType == .Half_H) && _sendTime != nil {
            _sendTime.invalidate()
            _sendTime = nil
        }
        
    }
    //结束拖曳
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (_adsType == .Default_H || _adsType == .Half_H) && _imageUrls.count > 1 && _sendTime == nil {
            self.updateCollection()
        }
        
    }
    //惯性滑动结束
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if _adsType == .Default_H {
            // 将collectionView在控制器view的中心点转化成collectionView上的坐标
            let pInView = self.convertPoint(self.collectionView.center, toView: self.collectionView)
            // 获取这一点的indexPath
            let indexPathNow = self.collectionView.indexPathForItemAtPoint(pInView)
            // 赋值给记录当前坐标的变量
            self.itemIdex = (indexPathNow?.item)!
            
            // 更新数据
            self.changePageValue()
            // ...
        }
        if _adsType == .Half_H {
            // 获取当前显示的cell的下标
            let lastIndexPath = self.collectionView.indexPathsForVisibleItems().first
            print(lastIndexPath?.item)
            self.itemIdex = (lastIndexPath?.item)!
            // 更新数据
            self.changePageValue()
            // ...
        }
        
        
    }
    //MARK:---------- UICollectionViewDelegateFlowLayout
    //布局确定每个Item 的大小
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return _itemSize
    }
    //布局确定每个section内的Item距离section四周的间距 UIEdgeInsets
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    //返回每个section内上下两个Item之间的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        if _adsType == .Half_H {
            return frame.size.width - (_itemSize.width * 2)
        }
        if _adsType == .ImageBrowse_V {//上下
           return 3
            //return (frame.size.height%_itemSize.height)/(frame.size.height/_itemSize.height)
            
        }
        if _adsType == .ImageBrowse_H {//左右
            return 3
            //return (frame.size.width%_itemSize.width)/(frame.size.width/_itemSize.width)
            
        }
        return 0;
    }
    //返回每个section内左右两个Item之间的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        if _adsType == .Half_H {
            return 0
        }
        if _adsType == .ImageBrowse_V{//左右
            //return (frame.size.width%_itemSize.width)/(frame.size.width/_itemSize.width)
            return 3
        }
        if _adsType == .ImageBrowse_H {//上下
            //return (frame.size.height%_itemSize.height)/(frame.size.height/_itemSize.height)
            return 3
        }
        
        return 0;
    }
    //MARK:----------- 核心动画
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    
    func makePerspectiveTransform() -> CATransform3D {
        var transform = CATransform3DIdentity;
        transform.m34 = 1.0 / -2000;
        return transform;
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

extension LCDAdsView {
    class func show(view:UIView ,frame: CGRect, adsType: LCDAdsViewType, imageUrls: [String],isUrlImage:Bool = true , time: NSTimeInterval = 5.0, itemSize:CGSize = CGSizeMake(0, 0)) -> LCDAdsView {
        for subView in view.subviews {
            if let adsView = subView as? LCDAdsView {
                adsView.frame = frame
                switch adsType {
                case .Default_H:
                    adsView._itemSize = CGSizeMake(frame.size.width, frame.size.height)
                default:
                    adsView._itemSize = itemSize
                }
                adsView._isUrlImage = isUrlImage
                adsView._imageUrls = imageUrls
                return adsView
            }
        }
        let adsView = LCDAdsView(frame: frame, adsType:adsType, time: time)
        view.addSubview(adsView)
        switch adsType {
        case .Default_H:
            adsView._itemSize = CGSizeMake(frame.size.width, frame.size.height)
        default:
            adsView._itemSize = itemSize
        }
        adsView._isUrlImage = isUrlImage
        adsView._imageUrls = imageUrls
        return adsView
    }
}

