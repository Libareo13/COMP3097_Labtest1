
import SwiftUI

struct ContentView: View {
    @State private var number = Int.random(in: 2...100)

    var body: some View {
        VStack {
            Text("\(number)")
                .font(.system(size: 72))
                .foregroundColor(.green)
        }
    }
}
