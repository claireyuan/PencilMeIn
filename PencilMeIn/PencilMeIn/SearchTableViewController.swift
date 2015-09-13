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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
//        self.searchBar.targetForAction(Selector("searchChanged()", withSender: searchBar))
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        let query = PFQuery(className: "Business")
        var dataNames: NSMutableArray? = NSMutableArray()
        var dataIds: NSMutableArray? = NSMutableArray()
        if(searchText != "") {
            query.whereKey("keywords", containedIn: [searchText]).findObjectsInBackgroundWithBlock { (objects, error) -> Void in
                if let objects = objects {
                    for o in objects {
                        print(o.objectForKey("name"))
                        print(o.objectId)
                        // o is an entry in the Follow table
                        // to get the user, we get the object with the to key
                        var businessName: String = o.objectForKey("name") as? String ?? ""
                        var businessId: String? = o.objectId
                        dataNames!.addObject(businessName)
                        if(businessId != nil){
                            dataIds!.addObject(businessId!)
                        }
                    }
                }
                println(dataNames)
                println(dataIds)
            }
            print("\(searchBar.text)")
        }
    }
    
    
}
