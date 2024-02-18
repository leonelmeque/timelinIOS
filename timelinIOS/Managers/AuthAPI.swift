import FirebaseAuth

extension NetworkManager {
    
    enum FirebaseError: Error {
        case userNotFound
        case failedToSignin(String)
        
        var description: String {
            switch self {
                case .userNotFound:
                    return "User was not found"
                case .failedToSignin(let error):
                    return error
            }
        }
    }

    func signInWith(email: String, password: String) async throws -> User {
      return try await withCheckedThrowingContinuation { continuation in
        Auth.auth().signIn(withEmail: email, password: password) {
            [weak self] _ , error in
            guard self != nil else {return}

            if let error = error {
              continuation.resume(throwing: FirebaseError.failedToSignin(error.localizedDescription))
                print("An error occured \(error)")
                return
            }

            guard let currentUser = Auth.auth().currentUser else {
              continuation.resume(throwing: FirebaseError.userNotFound)
                return}

            self?.authUser = currentUser

          continuation.resume(returning: currentUser)
        }
      }
    }
    
    func signUpWith(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password)
    }
}
