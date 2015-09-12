import Foundation
import Parse

class Event: PFObject, PFSubclassing {
    @NSManaged var title: String
    @NSManaged var employeeName: String
    @NSManaged var startTime: NSDate
    @NSManaged var endTime: NSDate
    
    @NSManaged var id: String
    
    init (title: String!, employeeName: String!, startTime: NSDate!, endTime: NSDate!) {
        super.init()
        self.title = title
        self.employeeName = employeeName
        self.startTime = startTime
        self.endTime = endTime
    }
    
    init (objectId: String!) {
        super.init()
        getFromServer(objectId)
    }
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Event"
    }
    
    func getBusiness() -> Business {
        var query: PFQuery = PFQuery(className: "BusinessEventJoinTable")
        query.whereKey("event", equalTo: self)
        var retVal: Business = Business(name: "", keywords: [""], address: "")
        query.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                for o in objects {
                    // o is an entry in the Follow table
                    // to get the user, we get the object with the to key
                    retVal = o.objectForKey("business") as! Business
                    break
                }
            }
        }
        return retVal
    }
    
    func getConsumer() -> Consumer {
        var query: PFQuery = PFQuery(className: "ConsumerEventJoinTable")
        query.whereKey("event", equalTo: self)
        var retVal: Consumer = Consumer(fullName: "", email: "", phone: "0000000000")
        query.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                for o in objects {
                    // o is an entry in the Follow table
                    // to get the user, we get the object with the to key
                    retVal = o.objectForKey("consumer") as! Consumer
                    break
                }
            }
        }
        return retVal
    }
    
    func getFromServer(objectId: String!) {
        var query = PFQuery(className:"Business")
        query.getObjectInBackgroundWithId(objectId) {
            (result: PFObject?, error: NSError?) -> Void in
            if error == nil && result != nil {
                let title = result?.objectForKey("title") as! String
                let employeeName = result?.objectForKey("employeeName") as! String
                let startTime = result?.objectForKey("startTime") as! NSDate
                let endTime = result?.objectForKey("endTime") as! NSDate
                
                self.title = title
                self.employeeName = employeeName
                self.startTime = startTime
                self.endTime = endTime
                
                self.id = objectId
            } else {
                println(error)
            }
        }
    }
    
    func putToServer() {
        var user = PFUser.currentUser()!
        self.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                println("Huzzah!")
            }
        }
    }
}