import ComposableArchitecture
import SwiftUI

@Reducer struct ArchiveDetailsFeature {
    
    @ObservableState
    struct State: Equatable {
        @Presents var alert: AlertState<Action.Alert>?
    }
    
    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case alert(PresentationAction<Alert>)
        
        case deleteButtonTapped
        case deleteSuccess
        enum Alert {
            case confirmDelete
        }
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .deleteButtonTapped:
                state.alert = AlertState {
                    TextState("archive.delete.confirm")
                } actions: {
                    ButtonState(role: .destructive, action: .confirmDelete) {
                        TextState("delete")
                    }
                    ButtonState(role: .cancel) {
                        TextState("cancel")
                    }
                }
                return .none
            case .alert(.presented(.confirmDelete)):
                return .none
            case .alert:
                return .none
            case .deleteSuccess:
                return .none
            case .binding:
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}

struct ArchiveDetailsV2: View {
    @Bindable var store: StoreOf<ArchiveDetailsFeature>
    
    var body: some View {
        ScrollView {
            Button(
                role: .destructive,
                action: { store.send(.deleteButtonTapped) },
                label: {
                    Text("archive.delete")
                }
            )
            .padding()
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Capsule())
            
        }
        .alert(
            $store.scope(state: \.alert, action: \.alert)
        )
    }
}
