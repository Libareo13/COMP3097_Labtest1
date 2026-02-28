
import SwiftUI

struct ContentView: View {

    @State private var number = Int.random(in: 1...100)
    @State private var isPrimeNumber = false
    @State private var showCorrect = false
    @State private var showWrong = false

    @State private var correctCount = 0
    @State private var wrongCount = 0
    @State private var attempts = 0

    @State private var showDialog = false

    var body: some View {
        VStack(spacing: 40) {

            Text("\(number)")
                .font(.system(size: 60))

            Button("Prime") {
                checkAnswer(userChoice: true)
            }

            Button("Not Prime") {
                checkAnswer(userChoice: false)
            }

            if showCorrect {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.green)
            }

            if showWrong {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.red)
            }
        }
        .alert("Results",
               isPresented: $showDialog) {
            Button("OK") {
                resetGame()
            }
        } message: {
            Text("Correct: \(correctCount)\nWrong: \(wrongCount)")
        }
        .onAppear {
            generateNumber()
        }
    }

    func generateNumber() {
        number = Int.random(in: 1...100)
        isPrimeNumber = isPrime(number)
    }

    func checkAnswer(userChoice: Bool) {

        attempts += 1

        if userChoice == isPrimeNumber {
            correctCount += 1
            showCorrect = true
            showWrong = false
        } else {
            wrongCount += 1
            showWrong = true
            showCorrect = false
        }

        if attempts == 10 {
            showDialog = true
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                generateNumber()
                showCorrect = false
                showWrong = false
            }
        }
    }

    func resetGame() {
        correctCount = 0
        wrongCount = 0
        attempts = 0
        generateNumber()
    }

    func isPrime(_ num: Int) -> Bool {
        if num < 2 { return false }
        for i in 2..<num {
            if num % i == 0 {
                return false
            }
        }
        return true
    }
}
