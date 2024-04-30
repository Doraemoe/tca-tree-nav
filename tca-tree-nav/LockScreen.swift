import ComposableArchitecture
import SwiftUI
import LocalAuthentication

@Reducer struct LockScreenFeature {
    @ObservableState
    struct State: Equatable {

    }

    enum Action: Equatable {
        
    }

    @Dependency(\.dismiss) var dismiss

    var body: some Reducer<State, Action> {
        Reduce { _, action in
            switch action {
            default:
                return .none
            }
        }
    }
}

struct LockScreen: View {
    @Bindable var store: StoreOf<LockScreenFeature>

    var body: some View {
        Text("abc")
    }
}
