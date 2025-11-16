import Foundation
import SkipFuse
#if os(Android)
import SkipFirebaseCore
@preconcurrency import SkipFirebaseFirestore
#else
import FirebaseCore
@preconcurrency import FirebaseFirestore
#endif

public struct Score: Identifiable {
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
        guard let user = dict["user"] as? DocumentReference else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "user must be a DocumentReference"))
        }
        guard let score = dict["score"] as? Int else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "score must be an Int"))
        }
        guard let timestamp = dict["updatedAt"] as? Timestamp else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "updatedAt must be a Timestamp"))
        }
        self.user = user
        self.score = score
        self.updatedAt = timestamp.dateValue()
    }
    
    @MainActor
    public func getUser() async throws -> User {
        return try await User(from: user.getDocument().data() ?? [:])
    }
}

public struct User {
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
        guard let name = dict["name"] as? String else {
            throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: [], debugDescription: "Expected 'name' to be a String"))
        }
        guard let uuid = dict["uuid"] as? String else {
            throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: [], debugDescription: "Expected 'uuid' to be a String"))
        }
        self.name = name
        self.uuid = uuid
    }
}
