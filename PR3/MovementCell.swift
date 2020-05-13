//
//  MovementCellTableViewCell.swift
//  PR3
//
//  Copyright © 2020 UOC. All rights reserved.
//

import UIKit

class MovementCell: UITableViewCell {
// BEGIN-UOC-4
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    func configure(Description description:String, Date date: String, Amount amount: String, AmountColor amountColor: UIColor, BackgroundColor backgroundColor: UIColor) {
        descriptionLabel.text = description
        dateLabel.text = date
        amountLabel.text = amount
        
        amountLabel.textColor = amountColor
        self.backgroundColor = backgroundColor
    }
    
    override func prepareForReuse() {
        descriptionLabel.text = ""
        dateLabel.text = ""
        amountLabel.text = ""
        
        self.backgroundColor = nil
    }
// END-UOC-4
}
