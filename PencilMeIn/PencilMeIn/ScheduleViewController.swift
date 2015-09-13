//
//  ScheduleViewController.swift
//  PencilMeIn
//
//  Created by Daphne Chen on 9/12/15.
//  Copyright (c) 2015 PencilMeIn. All rights reserved.
//

import UIKit
import EventKit

class ScheduleViewController: UICollectionViewController {
    
    var business: Business!

    @IBAction func addButton(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("addEvent", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextView = segue.destinationViewController as! AddEventViewController
        nextView.business = business
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        let collectionViewLayout = MSCollectionViewCalendarLayout()
        
//        self.collectionView!.collectionViewLayout = collectionViewLayout
    }
    

    
}


