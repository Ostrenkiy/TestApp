//
//  NameTableViewCell.swift
//  TestApp
//
//  Created by Alexander Karpov on 25.02.15.
//  Copyright (c) 2015 Alex Karpov. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
