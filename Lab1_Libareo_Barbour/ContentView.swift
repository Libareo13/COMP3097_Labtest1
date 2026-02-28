import SwiftUI

struct ContentView: View {

    @State private var number = Int.random(in: 2...100)
    @State private var correct = 0
    @State private var wrong = 0
    @State private var attempts = 0
    @State private var result: Bool? = nil

    func isPrime(_ n: Int) -> Bool {
        if n < 2 { return false }
        for i in 2...Int(Double(n).squareRoot()) {
            if n % i == 0 { return false }
        }
        return true
    }

    func checkAnswer(userPrime: Bool) {
        let right = isPrime(number) == userPrime

        if right { correct += 1 }
        else { wrong += 1 }

        attempts += 1
        result = right
    }

    var body: some View {
        VStack(spacing: 30) {

            Text("\(number)")
                .font(.system(size: 80, weight: .bold))
                .foregroundColor(.green)

            Button("Prime") {
                checkAnswer(userPrime: true)
            }

            Button("non Prime") {
                checkAnswer(userPrime: false)
            }
        }
    }
}

#Preview {
    ContentView()
}
