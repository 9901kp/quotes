//
//  quoteTableViewCell.swift
//  quotes
//
//  Created by Мухаммед Каипов on 17/6/24.
//

import UIKit

class quoteTableViewCell: UITableViewCell {

    @IBOutlet var textLbl: UILabel!
    static let identifier = "quoteTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
