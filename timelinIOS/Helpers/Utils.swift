import Foundation
import UIKit

class Utils {
  // Is important to note that the timestamp is in milliseconds 
  static func checkIfUpdateIsRecent(with timestamp: Double) -> Bool {
    let initialDate = Date(timeIntervalSince1970: timestamp / 1000)
    let calendar = Calendar.current
    let currentDate = Date()

    if let diff = calendar.dateComponents([.day], from: initialDate, to: currentDate).day {
      return diff < 5
    }

    return false
  }
}
