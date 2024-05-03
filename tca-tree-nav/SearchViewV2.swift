import ComposableArchitecture
import SwiftUI

@Reducer struct SearchFeature {

    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
        var archiveList = ArchiveListFeature.State()
        
        var editMode: EditMode = .inactive
    }

    enum Action: BindableAction {
        case destination(PresentationAction<Destination.Action>)
        case archiveList(ArchiveListFeature.Action)
        
        case binding(BindingAction<State>)
        
        case showAddCategory
    }

    var body: some ReducerOf<Self> {
        
        BindingReducer()

        Scope(state: \.archiveList, action: \.archiveList) {
            ArchiveListFeature()
        }

        Reduce { state, action in
            
            switch action {
            case .showAddCategory:
                state.destination = .add(NewCategoryFeature.State())
                return .none
            case .archiveList:
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
    
    @Reducer(state: .equatable)
    enum Destination {
        case add(NewCategoryFeature)
    }
}

struct SearchViewV2: View {
    @Bindable var store: StoreOf<SearchFeature>

    var body: some View {
            ArchiveListV2(store: store.scope(state: \.archiveList, action: \.archiveList))
            .navigationTitle("search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if store.editMode == .active {
                        Button("", systemImage: "plus.circle") {
                            store.send(.showAddCategory)
                        }
                        .popover(
                            item: $store.scope(state: \.destination?.add, action: \.destination.add)
                        ) { store in
                            NewCategory(store: store)
                        }
                    }
                    EditButton()
                }
            }
            .environment(\.editMode, $store.editMode)
            .toolbar(store.editMode == .active ? .hidden : .visible, for: .tabBar)
    }
}
