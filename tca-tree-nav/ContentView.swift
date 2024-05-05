import SwiftUI

struct ContentView: View {

    @State var tabName: String = "library"

    var body: some View {
        TabView(selection: $tabName) {
            libraryView
            searchView
        }
    }

    var libraryView: some View {
        NavigationStack{
            LibraryListV2()
        }
        .tabItem {
            Image(systemName: "books.vertical")
            Text("library")
        }
        .tag("library")
    }

    var searchView: some View {
        NavigationStack{
            SearchViewV2()
        }
        .tabItem {
            Image(systemName: "magnifyingglass")
            Text("search")
        }
        .tag("search")
    }
}
