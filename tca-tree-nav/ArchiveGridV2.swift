import SwiftUI

struct ArchiveGridV2: View {
    @State var name: String
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 2) {
            Text(name)
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
