//
//  ScheduleViewController.swift
//  PencilMeIn
//
//  Created by Daphne Chen on 9/12/15.
//  Copyright (c) 2015 PencilMeIn. All rights reserved.
//

import UIKit
import EventKit

class ScheduleViewController: UITableViewController {
    
    var business: Business!
    var events: [Event]=[]
    let formatter = NSDateIntervalFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        business.getEvents { (object) -> Void in
            self.events = object as! [Event]
            self.tableView.reloadData()
        }
        
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .MediumStyle
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Event Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let event = events[indexPath.row]
        cell.textLabel!.text = event.title
        
        cell.detailTextLabel!.text = formatter.stringFromDate(event.startTime, toDate: event.endTime)
        
        return cell
    }
    

}


