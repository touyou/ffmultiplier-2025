import Foundation
import OSLog
import Observation

#if !SKIP
import FirebaseCore
import FirebaseFirestore
#else
import SkipFirebaseCore
import SkipFirebaseFirestore
#endif

public actor FirebaseModel {
  private let firestore: Firestore
  
  public static var shared = FirebaseModel()
  
  public init() {
    self.firestore = Firestore.firestore()
  }
  
  @available(*, deprecated)
  private func initializeDatabaseAtOnece() async throws {
    let datas = try JSONDecoder().decode([String: OldScore].self, from: originalData.data(using: .utf8)!)
    for (key, value) in datas {
      let userDoc = firestore.collection("users").document()
      let user = User(name: value.name ?? "", uuid: key)
      let score = Score(user: userDoc, score: value.score, updatedAt: .now)
      try await userDoc.setData(user.data)
      try await firestore.collection("scores").addDocument(data: score.data)
    }
    print("completed")
  }
}

struct Score: Codable {
  let user: DocumentReference
  let score: Int
  let updatedAt: Date
  
  var data: [String: Any] {
    var data: [String: Any] = [:]
    data["user"] = user
    data["score"] = score
    data["updatedAt"] = updatedAt
    return data
  }
}

struct User: Codable {
  let name: String
  let uuid: String
  
  var data: [String: Any] {
    var data: [String: Any] = [:]
    data["name"] = name
    data["uuid"] = uuid
    return data
  }
}

struct OldScore: Codable {
  let name: String?
  let score: Int
}

private let originalData = #"""
"""#
