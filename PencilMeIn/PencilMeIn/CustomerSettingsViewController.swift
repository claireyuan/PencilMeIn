//
//  CustomerSettingsViewController.swift
//  PencilMeIn
//
//  Created by Claire Yuan on 9/12/15.
//  Copyright © 2015 PencilMeIn. All rights reserved.
//

import UIKit

class CustomerSettingsViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBAction func saveClicked(sender: UIBarButtonItem) {
        
        //check validity of name
        var containsSpace: Bool = false
        for character in nameTextField.text {
            if character == " " {
                containsSpace = true
            }
        }
        
        if !containsSpace {
            var alert = UIAlertController(title: "Please enter first and last name", message: "Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                self.nameTextField.text = ""
            }))
            
            presentViewController(alert, animated: true, completion: nil)
        }
        
        //check validity of email
        let emailCheck: [Character] = ["@","."]
        var i = 0
        for character in emailTextField.text {
            if i < emailCheck.count && character == emailCheck[i] {
                i++
            }
        }
        
        if i < emailCheck.count {
            var alert = UIAlertController(title: "Invalid Email Address", message: "Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                self.emailTextField.text = ""
            }))
            
            presentViewController(alert, animated: true, completion: nil)
        }
        
        //check validity of phone number
        if (NSString(string: phoneTextField.text).length != 10) {
            var alert = UIAlertController(title: "Invalid Phone Number", message: "Please enter 10 digits.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                self.phoneTextField.text = ""
            }))
            
            presentViewController(alert, animated: true, completion: nil)
        }


    }
    
    @IBAction func undoClicked(sender: UIBarButtonItem) {
        viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        nameTextField.text = getNameFromServer()
//        emailTextField.text = getEmailFromServer()
//        phoneTextField.text = getPhoneFromServer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

