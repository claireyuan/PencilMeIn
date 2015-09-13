import Foundation
import Parse

class Event: PFObject, PFSubclassing {
    @NSManaged var title: String
    @NSManaged var employeeName: String
    @NSManaged var startTime: NSDate
    @NSManaged var endTime: NSDate
    
    static func createEvent(title: String!, employeeName: String!, startTime: NSDate!, endTime: NSDate!, business: Business, consumer: Consumer) -> Event {
        var newObj: Event = Event()
        newObj.title = title
        newObj.employeeName = employeeName
        newObj.startTime = startTime
        newObj.endTime = endTime
        return newObj
    }

    func getBusiness() -> Business {
        var query: PFQuery = PFQuery(className: "BusinessEventJoinTable")
        query.whereKey("event", equalTo: self)
        var retVal: Business = Business()
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
        var retVal: Consumer = Consumer()
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
    
    override init () {
        super.init()
        self.title = ""
        self.employeeName = ""
        self.startTime = NSDate()
        self.endTime = NSDate()
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
        return "Event"
    }
}