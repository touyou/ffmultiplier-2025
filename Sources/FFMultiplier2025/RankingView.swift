import SwiftUI
import FFMultiplierModel

struct RankingView : View {
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
            let onlineRanking = await FirebaseModel.shared.watchRanking()
            self.rankingList = onlineRanking
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
            userName = score.userName
            userId = score.userId
        }
    }
}
