import Foundation
import Parse

class Business: PFObject, PFSubclassing {
    @NSManaged var user: PFUser
    @NSManaged var name: String
    @NSManaged var keywords: NSArray
    @NSManaged var address: String
    
    override init() {
        super.init()
    }

    static func createBusiness(name: String!, keywords: NSArray, address: String!) -> Business {
        var newObj = Business()
        newObj.user = PFUser.currentUser()!
        newObj.name = name
        newObj.keywords = keywords
        newObj.address = address
        return newObj
    }
    
    static func getUserConsumer(completion: (object: Business?) -> Void) {
        var business: Business?
        let query = PFQuery(className: "Business")
        query.whereKey("user", equalTo: PFUser.currentUser()!).getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if object != nil {
                println("Business.createConsumer: Huzzah!")
                business = object as? Business
            } else {
                println("Business.createConsumer: Nuzzah.")
            }
        }
        completion(object: business)
    }
    
    func getEvents(completion: (object: NSArray?) -> Void) {
        var query: PFQuery = PFQuery(className: "BusinessEventJoinTable")
        query.whereKey("business", equalTo: self)
        var data: NSMutableArray?
        query.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                data = NSMutableArray()
                for o in objects {
                    // o is an entry in the Follow table
                    // to get the user, we get the object with the to key
                    var otherUse: Event = o.objectForKey("event") as! Event
                    data!.addObject(otherUse)
                }
            }
        }
        completion(object: NSArray(array: data!))
    }
    
    func addEvent(event: Event) {
        event.saveInBackground()
        let joinTable = PFObject(className: "BusinessEventJoinTable")
        joinTable.setObject(self, forKey: "business")
        joinTable.setObject(event, forKey: "event")
        joinTable.saveInBackground()
    }
    
    func getFromServer(objectId: String!, completion: (object: Business?) -> Void) {
        let query = PFQuery(className: "Business")
        var business: Business?
        query.getObjectInBackgroundWithId(objectId) {
            (object: PFObject?, error: NSError?) -> Void in
            if error == nil && object != nil {
                println("success")
                business = object as? Business
            } else {
                println("error")
            }
        }
        completion(object: business)
    }
    
    func putToServer(completion: (object: Business) -> Void) {
        var user = PFUser.currentUser()!
        self.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                println("Business.putToServer: Huzzah!")
            } else {
                println("Business.putToServer: Nuzzah")
            }
        }
        completion(object: self)
    }
    
    //Private class functions
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    static func parseClassName() -> String {
        return "Business"
    }
    
}