import FirebaseFirestore 

extension NetworkManager {
    func getAllTodos() async throws -> [Todo] {
        let docRef = db.collection("todos").document("I83gWNye5ibHcaGNCzh6S4z66492").collection("list")
        var data: [Todo] = []
        do{
            let querySnapshot = try await docRef.getDocuments()
            let decoder = JSONDecoder()
            
            for document in querySnapshot.documents {
                let jsonData = try JSONSerialization.data(withJSONObject: document.data())
                
                let decodedObject = try decoder.decode(Todo.self, from: jsonData)
                data.append(decodedObject)
            }
            return data
        }catch {
            print(error)
            return data
        }
    }
}
