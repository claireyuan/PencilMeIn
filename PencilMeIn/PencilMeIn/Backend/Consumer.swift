import Foundation
import Parse

class Consumer: PFObject, PFSubclassing {
    @NSManaged var user: PFUser
    @NSManaged var fullName: String
    @NSManaged var email: String
    @NSManaged var phone: String
    
    //Initialize as the user!
    static func createConsumer (fullName: String!, email: String!, phone: String!) -> Consumer {
        var newObj: Consumer = Consumer()
        newObj.user = PFUser.currentUser()!
        newObj.fullName = fullName
        newObj.email = email
        newObj.phone = PhoneParser.parse(phone)
        return newObj
    }
    
    func getUserConsumer() -> Consumer {
        var consumer: Consumer? = nil
        let query = PFQuery(className: "Consumer")
        query.whereKey("user", equalTo: PFUser.currentUser()!).getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if object != nil {
                println("Consumer.createConsumer: Huzzah!")
                consumer = object as? Consumer
            } else {
                println("Consumer.createConsumer: Nuzzah.")
                consumer = Consumer()
            }
        }
        return consumer!
    }
    
    func getEvents() -> NSArray {
        var query: PFQuery = PFQuery(className: "ConsumerEventJoinTable")
        query.whereKey("consumer", equalTo: self)
        var data: NSMutableArray = NSMutableArray()
        query.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                for o in objects {
                    // o is an entry in the Follow table
                    // to get the user, we get the object with the to key
                    let otherUse = o.objectForKey("event") as! Event
                    data.addObject(otherUse)
                }
            }
        }
        return NSArray(array: data)
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
        self.fullName = ""
        self.email = ""
        self.phone = ""
        
    }
    
    func getFromServer(objectId: String!) {
        var query = PFQuery(className:"Consumer")
        query.getObjectInBackgroundWithId(objectId) {
            (result: PFObject?, error: NSError?) -> Void in
            if error == nil && result != nil {
                let fullName = result?.objectForKey("fullName") as! String
                let email = result?.objectForKey("email") as! String
                let phone = result?.objectForKey("phone") as! String
                self.fullName = fullName
                self.email = email
                self.phone = phone
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
        return "Consumer"
    }

}