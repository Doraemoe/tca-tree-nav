import ComposableArchitecture
import SwiftUI

@Reducer struct SettingsFeature {
    @ObservableState
    struct State: Equatable {
        var view = ViewSettingsFeature.State()
    }
    enum Action {
        case view(ViewSettingsFeature.Action)
    }

    var body: some ReducerOf<Self> {

        Scope(state: \.view, action: \.view) {
            ViewSettingsFeature()
        }
        Reduce { _, action in
            switch action {
            default:
                return .none
            }
        }
    }
}

struct SettingsView: View {
    @Bindable var store: StoreOf<SettingsFeature>

    var body: some View {

            Form {
                Section(
                    header: Text("settings.view"),
                    footer: Text("settings.archive.list.order.custom.explain")
                ) {
                    ViewSettings(store: self.store.scope(state: \.view, action: \.view))
                }
        }
    }
}
