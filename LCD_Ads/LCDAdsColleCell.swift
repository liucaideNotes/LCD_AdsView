//
//  LCDAdsColleCell.swift
//  iexbuy
//
//  Created by sifenzi on 16/5/18.
//  Copyright © 2016年 IEXBUY. All rights reserved.
//

import UIKit

class LCDAdsColleCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    func model(name:String, isUrlImage:Bool) {
        if isUrlImage {
            imageView.sd_setImageWithURL(NSURL(string: name), placeholderImage: UIImage(named: "placeholderImage"))
        }else{
            imageView.image = UIImage(named: name)
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
