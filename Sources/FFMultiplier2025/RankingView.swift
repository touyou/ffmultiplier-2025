import SwiftUI
import FFMultiplierModel

struct RankingView : View {
  @Environment(RankingViewModel.self) var viewModel: RankingViewModel
  @State private var rankingList: OnlineRankingList? = nil
  
  var body: some View {
    List {
      if let rankingList {
        ForEach(rankingList.scores) { score in
          RankItem(score: score)
        }
      }
    }
    .task {
      do {
        let onlineRanking = try await FirebaseModel.shared.watchRanking()
        self.rankingList = onlineRanking
      } catch {
        
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
