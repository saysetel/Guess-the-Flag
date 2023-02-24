//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Anastasia Kotova on 21.02.23.
//

import SwiftUI

struct InfoText : View {
    var text: String
    var conditionForColor: String
    
    var body: some View {
        Text(text)
            .foregroundColor(conditionForColor == "Correct" ? Color("darkGreen") : Color("darkRed"))
            .bold()
            .font(.title)
    }
}

struct ContentView: View {
    @State private var showingAlert = false
    @State private var title = ""
    @State private var message = ""
    @State private var score = 0
    @State private var questionCounter = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(stops: [
                .init(color: Color(red: 34/255, green: 34/255, blue: 59/255), location: 0.3),
                .init(color: Color(red: 201/255, green: 173/255, blue: 167/255), location: 0.3)]), center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack(spacing: 25) {
                Spacer()
                VStack {
                    Text("Guess the flag")
                        .foregroundColor(.white)
                        .font(.title)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    
                }
                Text("\(questionCounter)/8")
                    .foregroundColor(.white)
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .shadow(radius: 5)
                    }
                }
                VStack {
                    InfoText(text: title, conditionForColor: title)
                    InfoText(text: message, conditionForColor: title)
                }
                Spacer()
                Spacer()
            }
        }
        .alert("Finish!", isPresented: $showingAlert) {
            Button("Restart") {
                reset()
            }
        } message: {
            Text("Your score is \(score)")
        }
    }
    func deleteSection() {
        print("Section deleted")
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is \(score)"
            if questionCounter < 8 {
                questionCounter += 1
            }
        } else {
            title = "Wrong"
            if questionCounter < 8 {
                questionCounter += 1
            }
            message = "This was the flag of \(countries[correctAnswer])"
        }
        if questionCounter == 8 {
            showingAlert = true
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        questionCounter = 0
        score = 0
        title = ""
        message = ""
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
