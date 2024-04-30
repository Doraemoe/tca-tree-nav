import ComposableArchitecture
import SwiftUI

@Reducer struct AppFeature {

    @ObservableState
    struct State: Equatable {
        var tabName = "library"
        var successMessage = ""
        var errorMessage = ""

        var settings = SettingsFeature.State()
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)

        case settings(SettingsFeature.Action)
    }

    var body: some Reducer<State, Action> {
        BindingReducer()

        Scope(state: \.settings, action: \.settings) {
            SettingsFeature()
        }

        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }
}

struct ContentView: View {

    @Bindable var store: StoreOf<AppFeature>

    var body: some View {
        TabView(selection: $store.tabName) {
            settingsView
        }
    }

    var settingsView: some View {
        SettingsView(store: store.scope(state: \.settings, action: \.settings))
            .tabItem {
                Image(systemName: "gearshape")
                Text("settings")
            }
            .tag("settings")
    }
}
