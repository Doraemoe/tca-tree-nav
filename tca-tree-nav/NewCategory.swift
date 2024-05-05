import SwiftUI

struct NewCategory: View {
    @State var name: String = "a"

    var body: some View {
        Group {
            TextField("category.new.name", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
    }
}
