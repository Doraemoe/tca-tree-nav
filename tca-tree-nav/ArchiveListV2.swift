import ComposableArchitecture
import SwiftUI

@Reducer struct ArchiveListFeature {
    
    @ObservableState
    struct State: Equatable {
        var archives: IdentifiedArrayOf<GridFeature.State> = [
            GridFeature.State(name: "a"),
            GridFeature.State(name: "b")
        ]
    }
    
    enum Action: Equatable {
        case grid(IdentifiedActionOf<GridFeature>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
        .forEach(\.archives, action: \.grid) {
            GridFeature()
        }
    }
}

struct ArchiveListV2: View {
    @Bindable var store: StoreOf<ArchiveListFeature>
    
    let columns = [
        GridItem(.adaptive(minimum: 160), spacing: 20, alignment: .top)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(
                    store.scope(state: \.archives, action: \.grid)
                ) { gridStore in
                    grid(store: store, gridStore: gridStore)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func grid(
        store: StoreOf<ArchiveListFeature>,
        gridStore: StoreOf<GridFeature>
    ) -> some View {
        NavigationLink(
            state: AppFeature.Path.State.details(
                ArchiveDetailsFeature.State.init()
            )
        ) {
            ArchiveGridV2(store: gridStore)
        }
    }
}
