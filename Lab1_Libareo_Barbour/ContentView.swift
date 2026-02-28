import SwiftUI

struct ContentView: View {

    @State private var number = Int.random(in: 2...100)
    @State private var correct = 0
    @State private var wrong = 0
    @State private var attempts = 0
    @State private var result: Bool? = nil
    @State private var showAlert = false

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

        if attempts % 10 == 0 {
            showAlert = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            number = Int.random(in: 2...100)
            result = nil
        }
    }

    var body: some View {
        VStack {

            Spacer()

            Text("\(number)")
                .font(.system(size: 80, weight: .bold))
                .foregroundColor(.green)

            Button("Prime") {
                checkAnswer(userPrime: true)
            }

            Button("non Prime") {
                checkAnswer(userPrime: false)
            }

            Spacer()

            if let r = result {
                Image(systemName: r ? "checkmark" : "xmark")
                    .font(.system(size: 120))
                    .foregroundColor(r ? .green : .red)
            }

            Spacer()
        }
        .alert("Results", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Correct: \(correct)\nWrong: \(wrong)")
        }
    }
}

#Preview {
    ContentView()
}
