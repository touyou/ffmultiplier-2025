import SwiftUI

struct SettingsView : View {
    @Binding var appearance: String
    @Binding var welcomeName: String
    
    var body: some View {
        Form {
            TextField("Name", text: $welcomeName)
            Picker("Appearance", selection: $appearance) {
                Text("System").tag("")
                Text("Light").tag("light")
                Text("Dark").tag("dark")
            }
            if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
               let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                Text("Version \(version) (\(buildNumber))")
            }
            HStack {
                PlatformHeartView()
                Text("Powered by [Skip](https://skip.tools)")
            }
        }
    }
}

/// A view that shows a blue heart on iOS and a green heart on Android.
struct PlatformHeartView : View {
    var body: some View {
#if SKIP
        ComposeView { ctx in // Mix in Compose code!
            androidx.compose.material3.Text("💚", modifier: ctx.modifier)
        }
#else
        Text(verbatim: "💙")
#endif
    }
}
