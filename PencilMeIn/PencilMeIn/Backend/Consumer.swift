import Foundation
import Parse

class Consumer: PFObject, PFSubclassing {
    @NSManaged var user: PFUser
    @NSManaged var fullName: String
    @NSManaged var email: String
    @NSManaged var phone: String
    
    static func createConsumer (fullName: String!, email: String!, phone: String!) -> Consumer {
        var newObj: Consumer = Consumer()
        newObj.user = PFUser.currentUser()!
        newObj.fullName = fullName
        newObj.email = email
        newObj.phone = PhoneParser.parse(phone)
        return newObj
    }

    static func getUserConsumer(completion: (object: Consumer?) -> Void) {
        var consumer: Consumer?
        let query = PFQuery(className: "Consumer")
        query.whereKey("user", equalTo: PFUser.currentUser()!).getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if object != nil {
                println("Consumer.createConsumer: Huzzah!")
                consumer = object as? Consumer
            } else {
                println("Consumer.createConsumer: Nuzzah.")
            }
        }
        completion(object: consumer)
    }
    
    func getEvents(completion: (object: NSArray?) -> Void) {
        var query: PFQuery = PFQuery(className: "ConsumerEventJoinTable")
        query.whereKey("consumer", equalTo: self)
        var data: NSMutableArray?
        query.findObjectsInBackgroundWithBlock {
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
    
    func attachToEvent(event: Event) {
        event.saveInBackground()
        let joinTable = PFObject(className: "ConsumerEventJoinTable")
        joinTable.setObject(self, forKey: "consumer")
        joinTable.setObject(event, forKey: "event")
        joinTable.saveInBackground()
    }
    
    override init() {
        super.init()
    }
    
    func getFromServer(objectId: String!, completion: (object: Consumer?) -> Void) {
        let query = PFQuery(className: "Consumer")
        var consumer : Consumer?
        query.getObjectInBackgroundWithId(objectId) {
            (object: PFObject?, error: NSError?) -> Void in
            if error == nil && object != nil {
                println("success")
                consumer = object as? Consumer
            } else {
                println("error")
            }
        }
        completion(object: consumer)
    }
    
    func putToServer(completion: (object: Consumer) -> Void) {
        var user = PFUser.currentUser()!
        self.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                println("Consumer.putToServer: Huzzah!")
            } else {
                println("Consumer.putToServer: Nuzzah")
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
        return "Consumer"
    }

}