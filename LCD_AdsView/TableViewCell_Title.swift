//
//  TableViewCell_Title.swift
//  LCD_AdsView
//
//  Created by 刘才德 on 16/8/24.
//  Copyright © 2016年 sifenzi. All rights reserved.
//

import UIKit

class TableViewCell_Title: UITableViewCell {

    class func dequeueReusable(tableView:UITableView, indexPath:NSIndexPath) -> TableViewCell_Title {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell_Title", forIndexPath: indexPath) as! TableViewCell_Title
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    
    
    @IBOutlet weak var titleLab: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
