#if !SKIP
import FirebaseCore
import FirebaseFirestore
#else
import SkipFirebaseCore
import SkipFirebaseFirestore
#endif

#if !SKIP

extension FirebaseModel {
  @available(*, deprecated)
  public func initializeDatabaseAtOnece() async throws {
    let datas = try JSONDecoder().decode([String: OldScore].self, from: originalData.data(using: .utf8)!)
    for (key, value) in datas {
//      let userDoc = firestore.collection("users").document()
//      let user = User(name: value.name ?? "", uuid: key)
//      let score = Score(user: userDoc, score: value.score, updatedAt: .now)
//      try await userDoc.setData(user.data)
//      try await firestore.collection("scores").addDocument(data: score.data)
    }
    print("completed")
  }
}

struct OldScore: Codable {
  let name: String?
  let score: Int
}

private let originalData = #"""
"""#
#endif
