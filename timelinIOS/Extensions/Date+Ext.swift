import Foundation

extension Date {
  static func dateFormatter(from timestamp: Double) -> String {
    let _timestamp = Date(timeIntervalSince1970: timestamp / 1000)

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMM yyyy"
    dateFormatter.locale = Locale(identifier: "en_US")

    let formattedDate = dateFormatter.string(from: _timestamp)

    return formattedDate
  }
}
