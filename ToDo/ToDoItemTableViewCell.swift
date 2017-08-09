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
    var onSwitchSelected: ((UISwitch) -> Unit)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        isCompleteSwitch.addTarget(self, action: #selector(switchChanged), for: UIControlEvents.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func switchChanged(switch: UISwitch) -> Unit {
        if let f = onSwitchSelected {
            return f(switch)
        }
    }
}
