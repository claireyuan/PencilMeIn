//
//  AppointmentTableCell.swift
//  PencilMeIn
//
//  Created by Claire Yuan on 9/12/15.
//  Copyright © 2015 PencilMeIn. All rights reserved.
//

import UIKit

class AppointmentTableCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var ServiceLabel: UILabel!
    @IBOutlet weak var BusinessLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
