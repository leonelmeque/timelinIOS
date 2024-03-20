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
        } catch {
            print(error)
            return data
        }
    }

  func getPinnedAndRecentlyChangedTodo() async throws -> TodoForSection? {
    var data: TodoForSection?

    do{
      let querySnapshot = try await db.collection("todos").document("I83gWNye5ibHcaGNCzh6S4z66492").getDocument()

      let decoder = JSONDecoder()
      let jsonData = try JSONSerialization.data(withJSONObject: querySnapshot.data())

      let decodedObject = try decoder.decode(TodoForSection.self, from: jsonData)

      data = decodedObject

    } catch{
      print(error)

    }

    return data
  }

  func getTodoWith(id: String) async throws -> Todo? {
    let docRef = db.collection("todos").document("I83gWNye5ibHcaGNCzh6S4z66492").collection("list").document(id)
    var data: Todo? = nil

    do {
      let querySnapshot = try await docRef.getDocument()
      let decoder = JSONDecoder()

      let jsonData = try JSONSerialization.data(withJSONObject: querySnapshot.data())
      let decodedObject = try decoder.decode(Todo.self, from: jsonData)
      data = decodedObject
    } catch {
      print(error)
      return data
    }

    return data
  }

  func updateTodoWith(id: String = "tQObrDbLFDEnNcWf6zX3",with data: [String: Any]) async throws {
    let docRef = db.collection("todos").document("I83gWNye5ibHcaGNCzh6S4z66492").collection("list").document("tQObrDbLFDEnNcWf6zX3")

    do {
      _ = try? await docRef.updateData(data)
    } catch {
      print(error)
    }
  }


}
