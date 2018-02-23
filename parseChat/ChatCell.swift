//
//  ChatCell.swift
//  parseChat
//
//  Created by Jiaqi He on 2/21/18.
//  Copyright © 2018 Jiaqi He. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    @IBOutlet weak var chatMessageField: UILabel!
    @IBOutlet weak var usernameField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
