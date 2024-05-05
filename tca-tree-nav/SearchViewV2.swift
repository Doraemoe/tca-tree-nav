import SwiftUI

struct SearchViewV2: View {

    @State var editMode: EditMode = .inactive
    @State var showPopover = false
    
    var body: some View {
            ArchiveListV2()
            .navigationTitle("search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if editMode == .active {
                        Button("", systemImage: "plus.circle") {
                            showPopover = true
                        }
                        .popover(isPresented: $showPopover) {
                            NewCategory()
                        }
                    }
                    EditButton()
                }
            }
            .environment(\.editMode, $editMode)
            .toolbar(editMode == .active ? .hidden : .visible, for: .tabBar)
    }
}
