import Foundation
import SkipFuse
#if os(Android)
import SkipFirebaseCore
import SkipFirebaseFirestore
#else
import FirebaseCore
import FirebaseFirestore
#endif

#if !SKIP

// The following migration function was deprecated and incomplete.
// It has been removed to avoid confusion and code clutter.

struct OldScore: Codable {
  let name: String?
  let score: Int
}

private let originalData = #"""
"""#
#endif
