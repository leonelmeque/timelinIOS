import Foundation

struct UserInfoPhoneNumber: Codable{
  let countryCode: String
    let number: String
}

struct UserInfo: Codable {
    let id: String
    let username: String
    let preferences: [String]
    let phoneNumber: UserInfoPhoneNumber
    let email: String
}
