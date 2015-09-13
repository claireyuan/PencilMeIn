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
        
        print("\(searchBar.text)")
    }
    
    
}
