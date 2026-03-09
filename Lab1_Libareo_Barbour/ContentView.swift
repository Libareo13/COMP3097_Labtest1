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
    @State private var timer: Timer? = nil
    @State private var timeRemaining = 5
    var body: some View {
        VStack {
            Spacer()
            Text("\(number)")
                .font(.system(size: 80, weight: .bold, design: .rounded))
                .foregroundColor(.green)
                .italic()
                .padding(.bottom, 10)
            Button(action: {
                checkAnswer(userChoice: true)
            }) {
                Text("Prime")
                    .font(.system(size: 28))
                    .italic()
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 5)
            Button(action: {
                checkAnswer(userChoice: false)
            }) {
                Text("non Prime")
                    .font(.system(size: 28))
                    .italic()
                    .foregroundColor(.gray)
            }
            Spacer()
            if showCorrect {
                Image(systemName: "checkmark")
                    .font(.system(size: 120, weight: .bold))
                    .foregroundColor(.green)
            }
            if showWrong {
                Image(systemName: "xmark")
                    .font(.system(size: 120, weight: .bold))
                    .foregroundColor(.red)
            }
            Spacer()
            Text("\(attempts)")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
        }
        .alert("Results after \(attempts) attempts",
               isPresented: $showDialog) {
            Button("OK") {
                resetGame()
            }
        } message: {
            Text("Correct: \(correctCount)\nWrong: \(wrongCount)")
        }
        .onAppear {
            generateNumber()
            startTimer()
        }
    }
    func generateNumber() {
        number = Int.random(in: 1...100)
        isPrimeNumber = isPrime(number)
    }
    func startTimer() {
        timer?.invalidate()
        timeRemaining = 5
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            timeRemaining -= 1
            if timeRemaining <= 0 {
                timer?.invalidate()
                handleTimeout()
            }
        }
    }
    func handleTimeout() {
        wrongCount += 1
        attempts += 1
        showWrong = true
        showCorrect = false
        if attempts == 10 {
            showDialog = true
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showWrong = false
                generateNumber()
                startTimer()
            }
        }
    }
    func checkAnswer(userChoice: Bool) {
        timer?.invalidate()
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
                startTimer()
            }
        }
    }
    func resetGame() {
        correctCount = 0
        wrongCount = 0
        attempts = 0
        generateNumber()
        startTimer()
    }
    func isPrime(_ num: Int) -> Bool {
        if num < 2 { return false }
        if num < 4 { return true }
        for i in 2...Int(Double(num).squareRoot()) {
            if num % i == 0 { return false }
        }
        return true
    }
}