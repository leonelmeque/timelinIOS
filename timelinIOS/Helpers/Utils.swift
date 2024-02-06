import Foundation

class Utils {
  // Is important to note that the timestamp is in milliseconds 
  static func checkIfUpdateIsRecent(with timestamp: Double) -> Bool {
    let initialDate = Date(timeIntervalSince1970: timestamp / 1000)
    let calendar = Calendar.current
    let currentDate = Date()

    if let diff = calendar.dateComponents([.day], from: initialDate, to: currentDate).day {
      print(diff)
      return diff < 5
    }

    return false
  }

  static func motivationMessage() {

  }
}
