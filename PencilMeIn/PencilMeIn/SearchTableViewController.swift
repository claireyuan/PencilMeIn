//
//  SearchTableViewController.swift
//  PencilMeIn
//
//  Created by Claire Yuan on 9/13/15.
//  Copyright (c) 2015 PencilMeIn. All rights reserved.
//

import UIKit
import Parse

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var businesses: NSMutableArray = [] //business list

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
//        self.searchBar.targetForAction(Selector("searchChanged()", withSender: searchBar))
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        let query = PFQuery(className: "Business")
        var data: NSMutableArray? = []
        if(searchText != "") {
            query.whereKey("keywords", containedIn: [searchText]).findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                if let objects = objects {
                    for o in objects {
                        data!.addObject(o)
                    }
                    if(data != []) {
                        self.businesses = data!
                        self.tableView.reloadData()
                        println(data)
                    }
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Business Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let business: Business = businesses[indexPath.row] as! Business
        cell.textLabel!.text = business.name

        return cell
    }  
}
