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
    
    var business: Business!
    var name: String?
    var employeeName: String?
    
    @IBAction func eventNameChanged(sender: UITextField) {
        var eventName: String = sender.text
        self.name = eventName
        print(eventName)
        if eventName != "" && employeeName != "" {
            saveButton.enabled = true
        }
    }
    
    @IBAction func employeeNameChanged(sender: UITextField) {
        self.employeeName = sender.text
        print(employeeName)
        if self.name != "" && self.employeeName != "" {
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
            var alert = UIAlertController(title: "Your end date must be after your start date", message: "Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            
            presentViewController(alert, animated: true, completion: nil)
        } else if let a = self.name {
            if let b = self.employeeName {
                //TODO: add event to server
                business.addEvent(Event.createEvent(self.name, employeeName: self.employeeName, startTime: startDatePicker.date, endTime: startDatePicker.date))
                
                dismissViewControllerAnimated(true, completion: nil)
            }
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
        Business.getFromServer { (object) -> Void in
            if let a = object {
                self.business = a
            }
        }
        saveButton.enabled = false
    }
    
}


