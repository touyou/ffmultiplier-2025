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
        userId
    }

    public let userId: String
    public let userName: String
    public let score: Int
    public let updatedAt: Date

    public var data: [String: Any] {
        var data: [String: Any] = [:]
        data["userId"] = userId
        data["userName"] = userName
        data["score"] = score
        data["updatedAt"] = updatedAt
        return data
    }

    public init(user: User, score: Int, updatedAt: Date) {
        self.userId = user.uuid
        self.userName = user.name
        self.score = score
        self.updatedAt = updatedAt
    }

    public init(from dict: [String: Any]) throws {
        guard let userId = dict["userId"] as? String else {
            throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: [], debugDescription: "userId must be a String"))
        }
        guard let userName = dict["userName"] as? String else {
            throw DecodingError.typeMismatch(String.self, DecodingError.Context(codingPath: [], debugDescription: "userName must be a String"))
        }
        guard let score = dict["score"] as? Int else {
            throw DecodingError.typeMismatch(Int.self, DecodingError.Context(codingPath: [], debugDescription: "score must be an Int"))
        }
        guard let timestamp = dict["updatedAt"] as? Timestamp else {
            throw DecodingError.typeMismatch(Timestamp.self, DecodingError.Context(codingPath: [], debugDescription: "updatedAt must be a Timestamp"))
        }
        self.userId = userId
        self.userName = userName
        self.score = score
        self.updatedAt = timestamp.dateValue()
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
