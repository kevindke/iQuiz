//
//  TableViewCell.swift
//  iQuiz
//
//  Created by Kevin Ke on 5/5/16.
//  Copyright © 2016 Kevin Ke. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
