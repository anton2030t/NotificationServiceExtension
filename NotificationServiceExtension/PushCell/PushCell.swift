//
//  PushCell.swift
//  NotificationServiceExtension
//
//  Created by Anton Larchenko on 01.07.2020.
//  Copyright © 2020 Anton Larchenko. All rights reserved.
//

import UIKit

class PushCell: UITableViewCell {

    static let identifier = "PushCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
