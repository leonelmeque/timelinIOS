import Foundation
import FirebaseFirestore
import FirebaseAuth

class NetworkManager {
  static let shared = NetworkManager()
  var authUser: User!
  let db =  Firestore.firestore()
}
