//
//  LoginViewController.swift
//  PencilMeIn
//
//  Created by Claire Yuan on 9/13/15.
//  Copyright (c) 2015 PencilMeIn. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginClicked(sender: UIButton) {
        let email = emailTextField.text
        let password = passwordTextField.text
        let serverController = ServerController()
        serverController.logInUser(email, password: password, completionBlock: { user in
            
            if let realUser = user {
                
                //get business 
                
                self.performSegueWithIdentifier("loginToBusiness", sender: sender)
            } else {
                let alert = UIAlertController(title: "Login Failed!", message: "Your username or password is incorrect.", preferredStyle: .Alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                
                self.presentViewController(alert, animated: true, completion: nil)
            }

        })
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if( segue.identifier == "loginToBusiness") {
            let tabBarController = segue.destinationViewController as! UITabBarController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}