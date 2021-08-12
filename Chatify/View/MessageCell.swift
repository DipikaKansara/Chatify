//
//  MessageCellTableViewCell.swift
//  Chatify
//
//  Created by Dipika Kansara on 11/8/21.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet var leftImg: UIImageView!
 
    @IBOutlet var MessageLbl: UILabel!
    @IBOutlet var rightImg: UIImageView!
    @IBOutlet var messageBubble: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
