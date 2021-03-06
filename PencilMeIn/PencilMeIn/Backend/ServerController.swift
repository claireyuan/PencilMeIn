import Foundation
import Parse

class ServerController {
    func signUpUser(username: String, password: String, email: String) -> Bool {
        var user = PFUser()
        user.username = username
        user.password = password
        user.email = email
        return user.signUp()
    }
    
    
//    func makeBusiness(name: String!, keywords: NSArray, address: String!, usersNeedApproval: Bool!, maxReschedules: Int, restrictPeriodHours: Int) {}
//    func getBusiness(objectId: String) -> Business {}
//    
//    func makeConsumer(fullName: String!) {}
//    func getConsumer(objectId: String) -> Consumer {}
//    
//    func makeEvent(businessId: String!, userId: String, startTime: NSDate!, endTime: NSDate!) { }
//    func getEvent(objectId: String) -> Event {}
    
    
    
    func logInUser(username: String, password: String, completionBlock: (PFUser?) -> Void) {
        
        PFUser.logInWithUsernameInBackground(username, password: password) { (user, error) -> Void in
            if(error == nil && user != nil) {
                println("success logging in")
            } else {
                println("no login")
            }
            completionBlock(user)
        }
    }
    
    //TODO: Add session-saving functionality
}