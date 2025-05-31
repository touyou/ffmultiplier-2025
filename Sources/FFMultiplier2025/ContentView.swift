import SwiftUI
import FFMultiplierModel

enum ContentTab: String, Hashable {
    case home, rankings, settings
}

struct ContentView: View {
    @AppStorage("tab") var tab = ContentTab.home
    @AppStorage("name") var welcomeName = "No Name"
    @AppStorage("appearance") var appearance = ""
    @State var viewModel = ViewModel()
    
    var body: some View {
        TabView(selection: $tab) {
            NavigationStack {
                WelcomeView(welcomeName: $welcomeName)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(ContentTab.home)
            
            NavigationStack {
                ItemListView()
                    .navigationTitle(Text("\(viewModel.items.count) Items"))
            }
            .tabItem {
                Label("Ranking", systemImage: "star.fill")
            }
            .tag(ContentTab.rankings)
            
            NavigationStack {
                SettingsView(appearance: $appearance, welcomeName: $welcomeName)
                    .navigationTitle("Settings")
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
            .tag(ContentTab.settings)
        }
        .environment(viewModel)
        .preferredColorScheme(appearance == "dark" ? .dark : appearance == "light" ? .light : nil)
    }
}
