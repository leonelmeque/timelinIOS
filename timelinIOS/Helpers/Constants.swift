import UIKit

enum BadgeUIColor {
    case on_going, completed, on_hold, todo
    
    var color: UIColor {
        switch self {
            case .on_going: 
                return UIColor(hex: "#F2F1FC")
            case .completed:
                return UIColor(hex: "#E6FAE6")
            case .on_hold:
                return UIColor(hex: "#F4F2D9" )
            case .todo:
                return UIColor(hex: "#FBF8ED")
        }
    }
}

enum BadgeTextColor {
    case on_going, completed, on_hold, todo
    
    var color: UIColor {
        switch self {
            case .on_going:
                return UIColor(hex: "#645CAA")
            case .completed:
                return UIColor(hex: "#5EAB5C")
            case .on_hold:
                return UIColor(hex: "#AAA25C" )
            case .todo:
                return UIColor(hex: "#645CAA")
        }
    }
}


enum TodoStatus {
    case on_going, completed, on_hold, todo
}
