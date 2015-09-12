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
    }
    
    @IBAction func startDatePicked(sender: UIDatePicker) {
        
    }
    
    @IBAction func endDatePicked(sender: UIDatePicker) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Create an Event Store instance
//        let eventStore = EKEventStore();
//        
//        // Use Event Store to create a new calendar instance
//        // Configure its title
//        let newCalendar = EKCalendar(forEntityType: EKEntityTypeEvent, eventStore: EKEventStore())
//        newCalendar.title = "calendar"
//        
//        // Access list of available sources from the Event Store
//        let sourcesInEventStore = eventStore.sources() as? [EKSource]
//        
//        // Filter the available sources and select the "Local" source to assign to the new calendar
//        // source property
//        newCalendar.source = sourcesInEventStore?.filter{
//            (source: EKSource) -> Bool in
//            source.sourceType.value == EKSourceTypeLocal.value
//            }.first
//        
//        // Save the calendar using the Event Store instance
//        var error: NSError? = nil
//        let calendarWasSaved = eventStore.saveCalendar(newCalendar, commit: true, error: &error)
//        
//        // Handle situation if the calendar could not be saved
//        if calendarWasSaved == false {
//            let alert = UIAlertController(title: "Calendar could not save", message: error?.localizedDescription, preferredStyle: .Alert)
//            let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
//            alert.addAction(OKAction)
//            
//            self.presentViewController(alert, animated: true, completion: nil)
//        }    else {
//            NSUserDefaults.standardUserDefaults().setObject(newCalendar.calendarIdentifier, forKey: "EventTrackerPrimaryCalendar")
        }
//    }
    
}


