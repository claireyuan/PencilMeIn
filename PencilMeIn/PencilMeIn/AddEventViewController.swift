//
//  AddEventViewController.swift
//  PencilMeIn
//
//  Created by Claire Yuan on 9/12/15.
//  Copyright (c) 2015 PencilMeIn. All rights reserved.
//

import UIKit
import EventKit

class AddEventViewController: UIViewController {
    
    @IBAction func eventNameChanged(sender: UITextField) {
        var eventName: String = sender.text
    }
    
    @IBAction func startDatePicked(sender: UIDatePicker) {
        var startDate: NSDate = sender.date
    }
    
    @IBAction func endDatePicked(sender: UIDatePicker) {
        var endDate: NSDate = sender.date
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


