//
//  ScheduleViewController.swift
//  PencilMeIn
//
//  Created by Daphne Chen on 9/12/15.
//  Copyright (c) 2015 PencilMeIn. All rights reserved.
//

import UIKit
import EventKit

class ScheduleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Business.getFromServer { (object) -> Void in
            if let business = object {
                // we have a business
            } else {
                // we don't :(
            }
        }
    }
    
}


