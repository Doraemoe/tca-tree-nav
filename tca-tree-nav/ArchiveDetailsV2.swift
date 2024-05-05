import SwiftUI

struct ArchiveDetailsV2: View {
    @State var showingAlert = false
    
    var body: some View {
        ScrollView {
            Button(
                role: .destructive,
                action: { showingAlert = true },
                label: {
                    Text("archive.delete")
                }
            )
            .padding()
            .background(.red)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
        .alert("archive.delete.confirm", isPresented: $showingAlert) {
            Button("cancel", role: .cancel) { }
            Button("delete", role: .destructive) {}
        }
    }
}
