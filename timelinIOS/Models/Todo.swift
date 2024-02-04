import Foundation


struct TodoForSection: Codable {
  var pinnedTodo: String?
  var latestChanged: String?
}

struct Todo: Codable {
    let id: String
    var creator: String
    var description: String
    var endDate: String?
    var startDate: String?
    var status: String
    var timestamp: Double
    var todo: String
    var participants: [String]
    var color: String
}
