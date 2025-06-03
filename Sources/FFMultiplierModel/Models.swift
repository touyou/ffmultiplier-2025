import Foundation

#if !SKIP
import FirebaseCore
import FirebaseFirestore
#else
import SkipFirebaseCore
import SkipFirebaseFirestore
#endif

public struct Score: Codable, Identifiable {
  public var id: String {
    user.documentID
  }
  
  public let user: DocumentReference
  public let score: Int
  public let updatedAt: Date
  
  public var data: [String: Any] {
    var data: [String: Any] = [:]
    data["user"] = user
    data["score"] = score
    data["updatedAt"] = updatedAt
    return data
  }
  
  public init(user: DocumentReference, score: Int, updatedAt: Date) {
    self.user = user
    self.score = score
    self.updatedAt = updatedAt
  }
  
  public init(from dict: [String: Any]) throws {
    if dict["user"] is String {
      throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "user must be DocumentReference"))
    }
    self.user = dict["user"] as! DocumentReference
    self.score = dict["score"] as! Int
    self.updatedAt = (dict["updatedAt"] as! Timestamp).dateValue()
  }
  
  public func getUser() async throws -> User {
    return try await User(from: user.getDocument().data() ?? [:])
  }
}

public struct User: Codable {
  public let name: String
  public let uuid: String
  
  public var data: [String: Any] {
    var data: [String: Any] = [:]
    data["name"] = name
    data["uuid"] = uuid
    return data
  }
  
  public init(name: String, uuid: String) {
    self.name = name
    self.uuid = uuid
  }
  
  public init(from dict: [String: Any]) throws {
    self.name = dict["name"] as! String
    self.uuid = dict["uuid"] as! String
  }
}
