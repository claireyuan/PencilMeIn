import Foundation
import Parse

class Event: PFObject, PFSubclassing {
    @NSManaged var title: String
    @NSManaged var employeeName: String
    @NSManaged var startTime: NSDate
    @NSManaged var endTime: NSDate
    
    static func createEvent(title: String!, employeeName: String!, startTime: NSDate!, endTime: NSDate!) -> Event {
        var newObj: Event = Event()
        newObj.title = title
        newObj.employeeName = employeeName
        newObj.startTime = startTime
        newObj.endTime = endTime
        return newObj
    }

    func getBusiness(completion: (object: Business?) -> Void) {
        var query: PFQuery = PFQuery(className: "BusinessEventJoinTable").whereKey("event", equalTo: self)
        var retVal: Business?
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if object != nil && error == nil {
                retVal = object as? Business
            } else {
                println("Error! No matching items in the DB!")
            }
        }
        completion(object: retVal)
    }
    
    func getConsumer(completion: (object: Consumer?) -> Void) {
        var query: PFQuery = PFQuery(className: "ConsumerEventJoinTable").whereKey("event", equalTo: self)
        var retVal: Consumer?
        query.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if object != nil && error == nil {
                retVal = object as? Consumer
            } else {
                println("Error! No matching items in the DB!")
            }
        }
        completion(object: retVal)
    }
    
    override init () {
        super.init()
    }
    
    func getFromServer(objectId: String!, completion: (object: Event?) -> Void) {
        let query = PFQuery(className:"Business")
        var event: Event?
        query.getObjectInBackgroundWithId(objectId) {
            (object: PFObject?, error: NSError?) -> Void in
            if error == nil && object != nil {
                println("success")
                event = object as? Event
            } else {
                println("error")
            }
        }
        completion(object: event)
    }
    
    func putToServer(completion: (object: Event) -> Void) {
        var user = PFUser.currentUser()!
        self.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                println("Event.putToServer: Huzzah!")
            } else {
                println("Event.putToServer: Nuzzah")
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
        return "Event"
    }
}