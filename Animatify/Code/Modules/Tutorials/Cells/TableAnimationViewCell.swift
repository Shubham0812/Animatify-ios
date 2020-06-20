//
//  TableAnimationViewCell.swift
//  Animatify
//
//  Created by Shubham Singh on 20/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class TableAnimationViewCell: UITableViewCell {
    override class func description() -> String {
        return "TableAnimationViewCell"
    }
    
    // MARK:- outlets for the viewController
    
    var tableViewHeight: CGFloat = 64
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
