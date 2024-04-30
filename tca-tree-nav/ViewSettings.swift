import ComposableArchitecture
import SwiftUI

@Reducer struct ViewSettingsFeature {
    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?

        var blurInterfaceWhenInactive = false
        var enablePasscode = false
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)

        case destination(PresentationAction<Destination.Action>)

        case setEnablePasscode(Bool)
        case showLockScreen
    }

    var body: some Reducer<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case let .setEnablePasscode(isEnable):
                state.enablePasscode = isEnable
                return .none
            case .showLockScreen:
                state.destination = .lockScreen(
                    LockScreenFeature.State()
                )
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }

    @Reducer(state: .equatable)
    enum Destination {
        case lockScreen(LockScreenFeature)
    }
}

struct ViewSettings: View {
    @Bindable var store: StoreOf<ViewSettingsFeature>

    var body: some View {
        List {
            Toggle(isOn: self.$store.blurInterfaceWhenInactive, label: {
                Text("settings.view.blur.inactive")
            })
            .padding()
            Toggle(isOn: self.$store.enablePasscode, label: {
                Text("settings.view.passcode")
            })
            .padding()
        }
        .onChange(of: store.enablePasscode) { oldPasscode, newEnable in
            if store.destination == nil {
                store.send(.showLockScreen)
            }
        }
        .fullScreenCover(
            item: $store.scope(state: \.destination?.lockScreen, action: \.destination.lockScreen)
        ) { store in
            LockScreen(store: store)
        }
    }
}
