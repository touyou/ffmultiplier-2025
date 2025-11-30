import Foundation
import Observation

#if os(Android)
import SkipFirebaseCore
@preconcurrency import SkipFirebaseFirestore
#else
import FirebaseCore
@preconcurrency import FirebaseFirestore
#endif

public actor FirebaseModel {
  private let firestore: Firestore

  public static let shared = FirebaseModel()

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

  public func watchRanking() async -> OnlineRankingList {
    return await MainActor.run {
      OnlineRankingList(firestore.collection("scores"))
    }
  }
}
