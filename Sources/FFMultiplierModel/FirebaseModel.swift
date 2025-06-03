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
  
  public func updateUserName(name: String, deviceId: String) async throws {
    let userQuery = firestore.collection("users").whereField("uuid", isEqualTo: deviceId)
    let userDocRef = try await userQuery.getDocuments().documents.first?.reference
    if userDocRef != nil {
      try await userDocRef?.updateData([
        "name": name
      ])
    } else {
       try await firestore.collection("users").addDocument(data: User(name: name, uuid: deviceId).data)
    }
  }
  
  @MainActor public func watchRanking() async throws -> OnlineRankingList {
    return await OnlineRankingList(firestore.collection("scores"))
  }
}

