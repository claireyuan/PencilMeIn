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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewLayout = MSCollectionViewCalendarLayout()
        
        self.collectionView!.collectionViewLayout = collectionViewLayout
        UICollectionViewCell.alloc()
        UICollectionReusableView.alloc()
    }
    

}


