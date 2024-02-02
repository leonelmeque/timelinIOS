import Foundation

struct Todo: Codable {
    let id: String
    var creator: String
    var description: String
    var endDate: String?
    var startDate: String?
    var status: String
    var timestamp: String
    var todo: String
    var participants: [String]
    var color: String
}
