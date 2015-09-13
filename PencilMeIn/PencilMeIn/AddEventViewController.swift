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
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBAction func eventNameChanged(sender: UITextField) {
        var eventName: String = sender.text
        
        if eventName != "" {
            saveButton.enabled = true
        }
    }
    
    @IBAction func startDatePicked(sender: UIDatePicker) {
        var startDate: NSDate = sender.date
    }
    
    @IBAction func endDatePicked(sender: UIDatePicker) {
        var endDate: NSDate = sender.date
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        if endDatePicker.date.compare(startDatePicker.date).rawValue <= 0  {
            var alert = UIAlertController(title: "End Date must be after Start Date", message: "Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            
            presentViewController(alert, animated: true, completion: nil)
        } else {
            //TODO: add event to server
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.enabled = false
    }
    
}


