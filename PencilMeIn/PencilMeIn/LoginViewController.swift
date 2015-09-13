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
    @IBOutlet weak var userNameTextField: UITextField!
    
    var business: Business!
    
//    @IBAction func registerClicked(sender: UIButton) {
//        let email = emailTextField.text
//        let password = passwordTextField.text
//        let username = userNameTextField.text
//        let serverController = ServerController()
//        serverController.signUpUser(username, password: password, email: email)
//        
//        Business.getFromServer { (object) -> Void in
//            if let business = object {
//                // we have a business
//                self.performSegueWithIdentifier("loginToBusiness", sender: sender)
//                
//            } else {
//                // we don't :(
//                self.business = Business.createBusiness("Test Business", keywords: NSArray(array: ["placeholder", "professional", "fun"]), address: "This be the address")
//            }
//        }
//
//    }
    
    @IBAction func loginClicked(sender: UIButton) {
        let email = emailTextField.text
        let password = passwordTextField.text
        let serverController = ServerController()
        serverController.logInUser(email, password: password, completionBlock: { user in
            
            if let realUser = user {
                Business.getFromServer { (object) -> Void in
                    if let business = object {
                        self.business = business
                        
                    } else {
                        // we don't :(
                        Consumer.getUserConsumer({ (object) -> Void in
                            if let consumer = object {
                                self.performSegueWithIdentifier("loginToConsumer", sender: sender)
                            } else {
                                let alert = UIAlertController(title: "Login Failed!", message: "You don't have a valid account.", preferredStyle: .Alert)
                                
                                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                                
                                self.presentViewController(alert, animated: true, completion: nil)
                            }
                        })
                    }
                    self.performSegueWithIdentifier("loginToBusiness", sender: sender)

                }
                
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
            let svc = tabBarController.viewControllers?[0].viewControllers?[0] as! ScheduleViewController
            svc.business = business
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