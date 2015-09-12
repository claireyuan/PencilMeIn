import Foundation
import Parse

class Business: PFObject, PFSubclassing {
    @NSManaged var name: String
    @NSManaged var keywords: NSArray
    @NSManaged var address: String
//    @NSManaged var usersNeedApproval: Bool
//    @NSManaged var approvedUsers: NSArray
//    @NSManaged var bannedUsers: NSArray
//    @NSManaged var maxReschedules: Int
//    @NSManaged var restrictPeriodHours: Int
    
    @NSManaged var id: String
    @NSManaged var user: PFUser
    
    init (name: String!, keywords: NSArray, address: String!/*, usersNeedApproval: Bool!, maxReschedules: Int, restrictPeriodHours: Int*/) {
        super.init()
        self.name = name
        self.keywords = keywords
        self.address = address
        self.user = PFUser.currentUser()!
//        self.usersNeedApproval = usersNeedApproval
//        self.approvedUsers = NSArray(array: [String()])
//        self.bannedUsers = NSArray(array: [String()])
//        self.maxReschedules = maxReschedules
//        self.restrictPeriodHours = restrictPeriodHours
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
        return "Business"
    }
    
    ///////////////////////////////////////
    ///////////////////////////////////////
    ///////////////////////////////////////
    ///////////////////////////////////////
    
    func getEvents() -> NSArray {
        var query: PFQuery = PFQuery(className: "BusinessEventJoinTable")
        query.whereKey("business", equalTo: self)
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
    
    func addEvent(event: Event) {
        let joinTable = PFObject(className: "BusinessEventJoinTable")
        joinTable.setObject(self, forKey: "business")
        joinTable.setObject(event, forKey: "event")
        joinTable.saveInBackground()
    }
    
    func getIdAsUser() {
        user = PFUser.currentUser()!
        let idQuery = PFQuery(className: "Business")
        println(idQuery.whereKey("user", equalTo: user).getFirstObject())
    }
    

    
    ///////////////////////////////////////
    ///////////////////////////////////////
    ///////////////////////////////////////
    ///////////////////////////////////////
    
    //User get from server
    func getFromServer() {
        let user = PFUser.currentUser()
        var query: PFQuery = PFQuery(className: "Business")
        query.whereKey("user", equalTo: user!)
        var retVal: String = String()
        query.findObjectsInBackgroundWithBlock{
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if let objects = objects {
                for o in objects {
                    // o is an entry in the Follow table
                    // to get the user, we get the object with the to key
                    retVal = o.objectForKey("objectId") as! String
                    break
                }
            }
        }
        getFromServer(retVal)
    }
    
    //Fetch from search
    func getFromServer(objectId: String!) {
        var query = PFQuery(className:"Business")
        query.getObjectInBackgroundWithId(objectId) {
            (result: PFObject?, error: NSError?) -> Void in
            if error == nil && result != nil {
                let name = result?.objectForKey("name") as! String
                let keywords = result?.objectForKey("keywords") as! NSArray
                let address = result?.objectForKey("address")as! String
//                let usersNeedApproval = result?.objectForKey("usersNeedApproval") as! Bool
//                let approvedUsers = result?.objectForKey("approvedUsers") as! NSArray
//                let bannedUsers = result?.objectForKey("bannedUsers") as! NSArray
//                let maxReschedules = result?.objectForKey("maxReschedules") as! Int
//                let restrictPeriodHours = result?.objectForKey("restrictPeriodHours") as! Int
                
                self.name = name
                self.keywords = keywords
                self.address = address
//                self.usersNeedApproval = usersNeedApproval
//                self.approvedUsers = approvedUsers
//                self.bannedUsers = bannedUsers
//                self.maxReschedules = maxReschedules
//                self.restrictPeriodHours = restrictPeriodHours
                
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