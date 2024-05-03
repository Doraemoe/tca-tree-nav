import ComposableArchitecture
import SwiftUI

@Reducer struct AppFeature {

    @ObservableState
    struct State: Equatable {
        var path = StackState<AppFeature.Path.State>()
        
        var tabName = "library"

        var library = LibraryFeature.State()
        var search = SearchFeature.State()
    }

    enum Action: BindableAction {
        case path(StackAction<AppFeature.Path.State, AppFeature.Path.Action>)
        
        case binding(BindingAction<State>)

        case library(LibraryFeature.Action)
        case search(SearchFeature.Action)
    }

    var body: some Reducer<State, Action> {
        BindingReducer()

        Scope(state: \.library, action: \.library) {
            LibraryFeature()
        }
        Scope(state: \.search, action: \.search) {
            SearchFeature()
        }

        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
    
    @Reducer(state: .equatable)
    enum Path {
        case details(ArchiveDetailsFeature)
    }
}

struct ContentView: View {

    @Bindable var store: StoreOf<AppFeature>

    var body: some View {
        TabView(selection: $store.tabName) {
            libraryView
            searchView
        }
    }

    var libraryView: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ) {
            LibraryListV2(store: store.scope(state: \.library, action: \.library))
        } destination: { store in
            switch store.case {
            case let .details(store):
                ArchiveDetailsV2(store: store)
            }
        }
        .tabItem {
            Image(systemName: "books.vertical")
            Text("library")
        }
        .tag("library")
    }

    var searchView: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ) {
            SearchViewV2(store: store.scope(state: \.search, action: \.search))
        } destination: { store in
            switch store.case {
            case let .details(store):
                ArchiveDetailsV2(store: store)
            }
        }
        .tabItem {
            Image(systemName: "magnifyingglass")
            Text("search")
        }
        .tag("search")
    }
}
