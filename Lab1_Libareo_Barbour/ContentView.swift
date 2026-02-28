
import SwiftUI

struct ContentView: View {

    @State private var number = Int.random(in: 2...100)
    @State private var correct = 0
    @State private var wrong = 0
    @State private var attempts = 0

    func isPrime(_ n: Int) -> Bool {
        if n < 2 { return false }
        for i in 2...Int(Double(n).squareRoot()) {
            if n % i == 0 { return false }
        }
        return true
    }

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
