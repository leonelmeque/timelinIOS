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

    func signInWith(email: String, password: String, completion: @escaping (Result<User, FirebaseError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {
            [weak self] _ , error in
            guard self != nil else {return}
            
            if let error = error {
                completion(.failure(.failedToSignin(error.localizedDescription)))
                print("An error occured \(error)")
                return
            }
            
            guard let currentUser = Auth.auth().currentUser else {
                completion(.failure(.userNotFound))
                return}
            
            self?.authUser = currentUser
            
            completion(.success(currentUser))
        }
    }
    
    func signUpWith(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password)
    }
}
