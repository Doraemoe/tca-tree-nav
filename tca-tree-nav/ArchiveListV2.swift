import SwiftUI

struct ArchiveListV2: View {
    @State var archives = ["a", "b"]
    
    let columns = [
        GridItem(.adaptive(minimum: 160), spacing: 20, alignment: .top)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(
                    archives, id: \.hashValue
                ) { name in
                    grid(name: name)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func grid(
        name: String
    ) -> some View {
        NavigationLink {
            ArchiveDetailsV2()
        } label: {
            ArchiveGridV2(name: name)
        }
    }
}
