import Foundation
import Parse

class ServerController {
    func signUpUser(username: String, password: String, email: String) {
        var user = PFUser()
        user.username = username
        user.password = password
        user.email = email
        if(user.signUp()) {
            println("Huzzah!")
        } else {
            println("Nuzzah!")
        }
    }
    
    
//    func makeBusiness(name: String!, keywords: NSArray, address: String!, usersNeedApproval: Bool!, maxReschedules: Int, restrictPeriodHours: Int) {}
//    func getBusiness(objectId: String) -> Business {}
//    
//    func makeConsumer(fullName: String!) {}
//    func getConsumer(objectId: String) -> Consumer {}
//    
//    func makeEvent(businessId: String!, userId: String, startTime: NSDate!, endTime: NSDate!) { }
//    func getEvent(objectId: String) -> Event {}
    
    
    
    func logInUser(username: String, password: String) {
        PFUser.enableRevocableSessionInBackground()
        PFUser.logInWithUsernameInBackground(username, password:password) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                println("Huzzah!")
            } else {
                println(error?.description)
            }
        }
    }
    
    //TODO: Add session-saving functionality
}