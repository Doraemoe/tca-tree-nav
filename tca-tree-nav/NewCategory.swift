import ComposableArchitecture
import SwiftUI

@Reducer struct NewCategoryFeature {

    @ObservableState
    struct State: Equatable {
        var name = ""
    }

    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
    }

    var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            }
        }
    }
}

struct NewCategory: View {
    @Bindable var store: StoreOf<NewCategoryFeature>

    var body: some View {
        Group {
            TextField("category.new.name", text: $store.name)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
    }
}
