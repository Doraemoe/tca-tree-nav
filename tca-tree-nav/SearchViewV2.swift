import ComposableArchitecture
import SwiftUI

@Reducer struct SearchFeature {

    @ObservableState
    struct State: Equatable {
        var archiveList = ArchiveListFeature.State()
    }

    enum Action: Equatable {
        case archiveList(ArchiveListFeature.Action)
    }

    var body: some ReducerOf<Self> {

        Scope(state: \.archiveList, action: \.archiveList) {
            ArchiveListFeature()
        }

        Reduce { state, action in
            switch action {
            case .archiveList:
                return .none
            }
        }
    }
}

struct SearchViewV2: View {
    @Bindable var store: StoreOf<SearchFeature>

    var body: some View {
            ArchiveListV2(store: store.scope(state: \.archiveList, action: \.archiveList))
            .navigationTitle("search")
            .navigationBarTitleDisplayMode(.inline)
    }
}
