import SwiftUI
import FFMultiplierModel
import OSLog

struct RankingView : View {
  @Environment(RankingViewModel.self) var viewModel: RankingViewModel
  @State private var rankingList: OnlineRankingList? = nil
  
  var body: some View {
    List {
      if let rankingList, !rankingList.scores.isEmpty {
        ForEach(rankingList.scores) { score in
          RankItem(score: score)
        }
      } else {
        Text("Empty")
      }
    }
    .task {
      do {
        let onlineRanking = try await FirebaseModel.shared.watchRanking()
        self.rankingList = onlineRanking
      } catch {
        logger.error("error: \(error)")
      }
    }
  }
}

struct RankItem: View {
  let score: Score
  @State private var userName: String?
  
  var body: some View {
    VStack(alignment: .leading) {
      if let userName {
        Text(userName.isEmpty ? "Anonymous" : userName)
      } else {
        ProgressView()
      }
      HStack {
        Text("\(score.score)pt").bold()
        Spacer()
        Text("\(score.updatedAt, style: .date) \(score.updatedAt, style: .time)").font(.footnote)
      }
    }
    .task {
      userName = (try? await score.getUser())?.name
    }
  }
}
