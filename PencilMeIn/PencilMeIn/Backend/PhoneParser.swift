import Foundation

class PhoneParser {
    static func parse(phone: String!) -> String { //Already cleaned so there are only 10 digits in it
        var retVal : NSMutableString = NSMutableString(string: phone)
        retVal.insertString("(", atIndex: 0)
        retVal.insertString(")", atIndex: 4)
        retVal.insertString("-", atIndex: 8)
        return String(retVal)
    }
}
