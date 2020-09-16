//
//  ContentView.swift
//  Day35-SwiftUI-Challenge
//
//  Created by Ezequiel Parada Beltran on 08/09/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        self.questionManager = QuestionManager()
    }
    @State var dragAmount = CGSize.zero
    @State var enabled = false
    let animals = [
        AnimalImage1(animal: "crocodile"),
        AnimalImage1(animal: "horse"),
        AnimalImage1(animal: "cow"),
        AnimalImage1(animal: "frog"),
        AnimalImage1(animal: "panda")
    ]
    // Parameter Properties
    @State var paramVisible = true // display of settings
    var tabNbQuestions = ["5", "10", "20", "all"]
    @State var nbQuestionSel = 1 // 10 by default
    @State var tableSel: Int = 3 // table of 3 by default
    
    // Game Properties
    @State var answer: String = ""
    @State var showingError = false
    @State var goodAnswerToast = false
    @State var badAnswerToast = false
    @State var qtCancelTapped = 0
    @State var displayValidButton = true
    @State var gameFinished = false
    
    // Questions
    @State var maximumQuestionAff = "10"
    @State var questionManager = QuestionManager()
    @State var actualQuestion = Question(firstNumber: 3, secondNumber: 1, position: 1)  // init
    
    // Animations
    
    @State var rotateValue = 0.0
    
    var body: some View {
        
        ZStack{
            // PARAM BLOCK
            if paramVisible {
                VStack {
                    Br(size: 150)
                    // Form block
                    VStack {
                        Text("Configuration")
                            .font(.largeTitle)
                            .foregroundColor(Color("color1"))
                            .padding(.top, 40)
                        // Phrase choose your table
                        HStack(alignment: .bottom, spacing: 0){
                            Text("Choose the multiplication ")
                            Text("table")
                                .fontWeight(.bold)
                                .foregroundColor(Color("color1"))
                        }
                        .padding(.top, 20)
                        .foregroundColor(Color("configText"))
                        
                        HStack(spacing: 8){
                            ForEach(1..<11){ number in
                                Rectangle()
                                    .frame(width:30, height: 30, alignment: .center)
                                    .foregroundColor(number == self.tableSel ? Color("color1") : Color("vert"))
                                    .animation(.default)
                                    .cornerRadius(8)
                                    .overlay(
                                        Button(action: {
                                            self.tableSel = number
                                        }){
                                            Text("\(number)")
                                                .foregroundColor(.white)
                                                .bold()
                                        }
                                )
                                
                            }
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 30)
                        
                        Text("Choose the number of questions:")
                            .foregroundColor(Color("configText"))
                            .padding(.top, 20)
                        Picker("Number of questions:", selection: $nbQuestionSel){
                            ForEach(0 ..< tabNbQuestions.count){
                                number in
                                Text(self.tabNbQuestions[number])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .foregroundColor(Color("color2"))
                        .padding()
                        
                        HStack(spacing: 18){
                            ForEach(0..<animals.count){ num in
                                self.animals[num]
                                    .offset(self.dragAmount)
                                    .animation(Animation.default.delay(Double(num)/10))
                                
                            }
                        }
                        .gesture(
                            DragGesture()
                                .onChanged {
                                    self.dragAmount = $0.translation
                            }
                            .onEnded{ _ in
                                self.dragAmount = .zero
                                self.enabled.toggle()
                            }
                        )
                            .padding(.top, 40)
                            .padding(.bottom, 40)
                        // Play Button
                        VStack{
                            Image("jouer")
                                .resizable()
                                .frame(width:200, height: 130)
                                .overlay(
                                    Button(action: {
                                        // launch new Game
                                        self.newGame()
                                        // hide params
                                        self.paramVisible.toggle()
                                        
                                    }){
                                        
                                        Text("PLAY").bold()
                                            .foregroundColor(Color("light"))
                                            .font(.title)
                                            .frame(width: 200, height: 130)
                                        
                                        
                                    }
                            )
                            
                            // Cancel Button
                            Button(action: {
                                self.cancelTapped()
                            }){
                                Text("Cancel")
                                    .underline()
                            }
                            .foregroundColor(Color("light"))
                            .padding(.top)
                            
                        } // end form block
                            .padding(.top, 10)
                            .padding(.bottom, 200)
                        Spacer()
                    }// Param block vstack
                    
                    
                }
                .background(Image("settingsBg")
                .resizable())
                .animation(.interactiveSpring())
                
                
            }// If is visible
            // SCORE FINISHED
            
            if gameFinished {
                // Game finished main
                VStack{
                    VStack{
                        Br(size: 160)
                        HStack{
                            Spacer()
                            VStack{
                                Text("SCORE !")
                                    .bold()
                                    .font(.largeTitle)
                                HStack(spacing: 0) {
                                    Text("\(questionManager.score)").bold().foregroundColor(Color("vert"))
                                    Text("/")
                                    Text(questionManager.maxQuestionAff)
                                }
                                .font(.largeTitle)
                            }
                            .foregroundColor(.white)
                            .modifier(vm_padding(top: 10, trailing: 30, bottom: 10, leading: 30))
                            .background(Color("color1"))
                            .cornerRadius(8)
                            .modifier(vm_border_r(radius: 8, color: .white, lineWidth: 2))
                            
                            Spacer()
                            
                        }
                        Br(size: 80)
                        
                        // New Game Button
                        Image("jouer")
                            .resizable()
                        frame(width: 200, height: 130)
                        overlay(
                            Button(action: {
                                self.newGame()
                                self.gameFinished.toggle()
                                self.paramVisible = true
                            }){
                                
                                VStack{
                                    Text("New").bold()
                                    Text("Game").bold()
                                }
                                .foregroundColor(Color("light"))
                                .font(.title)
                                frame(width: 180, height: 130, alignment: .center )
                            }
                        )
                    }
                    Spacer()
                }
                .background(Image("tropicalBackground").resizable())
                
            }
        }// ZStack
            .edgesIgnoringSafeArea(.all)
        
        
    } // body
    
    func cancelTapped() {
        // Start the game even if you cancel the first time you see the settings screen
        if qtCancelTapped == 0 {
            newGame()
            qtCancelTapped += 1
        }
        
        // hide params
        self.paramVisible.toggle()
    }
    
    func newGame() {
        //The QuestionManager is initialized (filled with questions depending on the settings), and returns the first question
        self.questionManager.newGame(nbQuestions: tabNbQuestions[nbQuestionSel], table: tableSel) {
            question in
            // We get the first question
            self.actualQuestion = question
        }
        resetInput()
        rotate1()
    }
    
    func padTapped(_ number: String) {
        // 3 digits maximum
        if answer.count <= 2 {
            answer += number
        }
    }
    
    func resetInput() {
        answer = ""
    }
    func rotate1() {
        withAnimation(.linear(duration: 0.4)){
            self.rotateValue += 360
        }
    }
    
    func userValidANswer() {
        displayValidButton = false
        // Nothing happens if the user has not answered
        if answer == "" {
            showingError.toggle()
            return
        }
        
        let wellAnswerd = answer == actualQuestion.goodAnswer.description
        // We update the question of the table to indicate if it was good or not
        questionManager.tabQuestion[questionManager.actualQuestionPosition].wellAnswerd = wellAnswerd
        // We tell the player if he got it or not
        if wellAnswerd { goodAnswerToast = true } else {
            badAnswerToast = true
        }
        // We wait 2 sec
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // we transfer the message
            if wellAnswerd { self.goodAnswerToast = false } else {
                self.badAnswerToast = false
            }
            // we reactivate the validation button
            self.displayValidButton = true
            // Resetting the entry
            self.resetInput()
            // Animation
            self.rotate1()
            // Go to score if game is finished
            if
                self.questionManager.actualQuestionPosition + 1 == self.questionManager.maxQuestionInt {
                withAnimation(.default){
                    self.gameFinished = true
                }
            } else {
                // The manager moves on to the next question
                self.questionManager.nextQuestion()
                //We update the current question
                self.actualQuestion = self.questionManager.getActualQuestion()
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
        
    }
}
