import Foundation
import SkipFuse
import SkipFuseUI

/// A logger for the FFMultiplier2025 module.
let logger: Logger = Logger(subsystem: "com.dev.touyou.FFMultiply", category: "FFMultiplier2025")

/// The shared top-level view for the app, loaded from the platform-specific App delegates below.
///
/// The default implementation merely loads the `ContentView` for the app and logs a message.
/* SKIP @bridge */public struct FFMultiplier2025RootView : View {
    /* SKIP @bridge */public init() {
    }

    public var body: some View {
        ContentView()
            .task {
                logger.info("Skip app logs are viewable in the Xcode console for iOS; Android logs can be viewed in Studio or using adb logcat")
            }
    }
}

/// Global application delegate functions.
///
/// These functions can update a shared observable object to communicate app state changes to interested views.
/* SKIP @bridge */public final class FFMultiplier2025AppDelegate : Sendable {
    /* SKIP @bridge */public static let shared = FFMultiplier2025AppDelegate()

    private init() {
    }

    /* SKIP @bridge */public func onStart() {
        logger.debug("onStart")
    }

    /* SKIP @bridge */public func onResume() {
        logger.debug("onResume")
    }

    /* SKIP @bridge */public func onPause() {
        logger.debug("onPause")
    }

    /* SKIP @bridge */public func onStop() {
        logger.debug("onStop")
    }

    /* SKIP @bridge */public func onDestroy() {
        logger.debug("onDestroy")
    }

    /* SKIP @bridge */public func onLowMemory() {
        logger.debug("onLowMemory")
    }
}
