import Foundation
import SkipFuse
import Observation
#if os(Android)
import SkipFirebaseCore
import SkipFirebaseFirestore
#else
import FirebaseCore
import FirebaseFirestore
#endif

/// A logger for the FFMultiplierModel module.
let logger: Logger = Logger(subsystem: "ffmultiplier.model", category: "FFMultiplierModel")

@Observable @MainActor public class OnlineRankingList {
  private var listener: ListenerRegistration? = nil
  public private(set) var scores: [Score] = []

  init(_ collection: CollectionReference) {
    let listener = collection.addSnapshotListener(includeMetadataChanges: true, listener: { [weak self] snap, err in
      if let err {
        logger.error("Failed to fetch ranking snapshot: \(String(describing: err))")
      }
      var _scores: [Score] = []
      if let snap = snap {
        for doc in snap.documents {
          let data = doc.data()
          do {
            let score = try Score(from: data)
            _scores.append(score)
          } catch {
            logger.error("Failed to decode score: \(error). data=\(data)")
          }
        }
      }
      _scores.sort { $0.score > $1.score }
      Task { @MainActor [weak self] in
        self?.scores = _scores
      }
    })

    self.listener = listener
  }
}
