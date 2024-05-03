import ComposableArchitecture
import SwiftUI

@Reducer struct GridFeature {
    @ObservableState
    struct State: Equatable, Identifiable {
        var id = UUID()
        
        var name: String
    }

    enum Action: Equatable {
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            }
        }
    }
}

struct ArchiveGridV2: View {
    let store: StoreOf<GridFeature>

    var body: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 2) {
            Text(store.name)
                .lineLimit(2)
                .foregroundColor(.primary)
                .padding(4)
                .font(.caption)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.secondary, lineWidth: 2)
                .opacity(0.9)
        )
    }
}
