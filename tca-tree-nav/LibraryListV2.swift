import ComposableArchitecture
import SwiftUI

@Reducer struct LibraryFeature {
    @ObservableState
    struct State: Equatable {
        var archiveList = ArchiveListFeature.State()
    }

    enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)

        case archiveList(ArchiveListFeature.Action)
    }

    var body: some ReducerOf<Self> {
        BindingReducer()

        Scope(state: \.archiveList, action: \.archiveList) {
            ArchiveListFeature()
        }

        Reduce { state, action in
            switch action {
            case .archiveList:
                return .none
            case .binding:
                return .none
            }
        }
    }
}

struct LibraryListV2: View {
    @Bindable var store: StoreOf<LibraryFeature>

    var body: some View {
        ArchiveListV2(store: store.scope(state: \.archiveList, action: \.archiveList))
            .navigationTitle("library")
            .navigationBarTitleDisplayMode(.inline)
    }
}
