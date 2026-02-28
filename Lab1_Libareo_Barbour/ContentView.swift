
import SwiftUI

struct ContentView: View {

    @State private var number = Int.random(in: 2...100)

    var body: some View {
        VStack(spacing: 30) {

            Text("\(number)")
                .font(.system(size: 80, weight: .bold))
                .foregroundColor(.green)

            Button("Prime") {}

            Button("non Prime") {}
        }
    }
}

#Preview {
    ContentView()
}
