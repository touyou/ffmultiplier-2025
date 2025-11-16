import SwiftUI
import FFMultiplierModel

struct RankingView : View {
    @Environment(RankingViewModel.self) var viewModel: RankingViewModel
    @State var rankingList: OnlineRankingList? = nil
    
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
    @State var userName: String?
    @State var userId: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let userName {
                    Text(userName.isEmpty ? "Anonymous" : userName)
                } else {
                    ProgressView()
                }
                if let userId {
                    Text(userId).font(.footnote)
                }
            }
            HStack {
                Text("\(score.score)pt").bold()
                Spacer()
                Text("\(score.updatedAt, style: .date) \(score.updatedAt, style: .time)").font(.footnote)
            }
        }
        .task {
            let user = try? await score.getUser()
            userName = user?.name
            userId = user?.uuid
        }
    }
}
