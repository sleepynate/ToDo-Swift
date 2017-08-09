//
//  ToDoItemTableViewCell.swift
//  ToDo
//
//  Created by nathan dotz on 7/27/17.
//  Copyright © 2017 Detroit Labs. All rights reserved.
//

import UIKit

class ToDoItemTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var isCompleteSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
