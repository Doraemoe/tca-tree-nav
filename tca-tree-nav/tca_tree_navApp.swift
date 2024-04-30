import ComposableArchitecture
import SwiftUI

@main
struct tcaTreeNavApp: App {

    let store = Store(initialState: AppFeature.State()) {
        AppFeature()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(store: self.store)
        }
    }
}
