//
//  TableViewCell_Title.swift
//  LCD_AdsView
//
//  Created by 刘才德 on 16/8/24.
//  Copyright © 2016年 sifenzi. All rights reserved.
//

import UIKit

class TableViewCell_Title: UITableViewCell {
    
    class func dequeueReusable(tableView:UITableView, indexPath:IndexPath) -> TableViewCell_Title {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell_Title", for: indexPath) as! TableViewCell_Title
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    @IBOutlet weak var titleLab: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
