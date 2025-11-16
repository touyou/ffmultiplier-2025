import SwiftUI
import FFMultiplierModel

enum ContentTab: String, Hashable {
    case home, rankings, settings
}

struct ContentView: View {
    @AppStorage("tab") var tab = ContentTab.home
    @AppStorage("name") var welcomeName = "No Name"
    @AppStorage("appearance") var appearance = ""
    @State var viewModel = RankingViewModel()
    
    var body: some View {
        TabView(selection: $tab) {
            Tab("Home", systemImage: "house.fill", value: ContentTab.home) {
                NavigationStack {
                    WelcomeView(welcomeName: $welcomeName)
                }
            }
            
            Tab("Ranking", systemImage: "star.fill", value: ContentTab.rankings) {
                NavigationStack {
                    RankingView()
                        .navigationTitle(Text("Ranking"))
                }
                .toolbarTitleDisplayMode(.inlineLarge)
            }
            
            Tab("Settings", systemImage: "gearshape.fill", value: ContentTab.settings) {
                NavigationStack {
                    SettingsView(appearance: $appearance, welcomeName: $welcomeName)
                        .navigationTitle("Settings")
                }
            }
        }
        .environment(viewModel)
        .preferredColorScheme(appearance == "dark" ? .dark : appearance == "light" ? .light : nil)
    }
}

