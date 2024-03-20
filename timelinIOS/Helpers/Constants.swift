import UIKit
import RxSwift

let ICON_SIZE = TLSpacing.s32.size

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

  var status: Observable<TodoStatus> {
    switch self {
    case .todo :
      return Observable.just(.todo)
    case .on_going:
      return Observable.just(.on_going)
    case .completed:
      return Observable.just(.completed)
    case .on_hold:
      return Observable.just(.on_hold)
    }
  }

  var stringfiedStatus: String {
    switch self {
    case .todo :
      return "Todo"
    case .on_going:
      return "On going"
    case .completed:
      return "Completed"
    case .on_hold:
      return "On hold"
    }
  }
}
