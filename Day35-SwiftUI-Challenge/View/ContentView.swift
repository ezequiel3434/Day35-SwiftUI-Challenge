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
            
            //BLOCK GAME
            VStack{ // Game main ZSTACK
                // Game without toast
                VStack{
                    Br(size: 70)
                    // Settings button
                    HStack(alignment: .center, spacing: 0){
                        Spacer()
                        HStack{
                            Image("giraffe")
                                .resizable()
                                .frame(width:30, height: 30)
                            Image(systemName: "gear")
                                .resizable()
                                .frame(width:20, height: 20)
                                .foregroundColor(Color(.white))
                                .offset(x: CGFloat(-10), y: CGFloat(0))
                            
                        }
                        .frame(width:100, height: 40)
                        .background(Color("vert"))
                        .cornerRadius(15)
                        .overlay(
                            Button(action: {
                                self.paramVisible.toggle()
                            }){
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white, lineWidth: 3)
                            }
                        )
                        // end settings button
                        Spacer()
                    }
                    HStack(spacing: 0){
                        Text("Table of ").bold()
                            .foregroundColor(Color("vert"))
                        Text("\(tableSel)")
                            .foregroundColor(Color("color2"))
                            .fontWeight(.black)
                            .modifier(vm_padding(top: 8, trailing: 12, bottom: 8, leading: 12))
                            .background(
                                Image("roundWood")
                                    .resizable()
                        )
                        Text("!")
                    }
                    .padding(.top, 0)
                    .font(.title)
                    HStack(alignment: .bottom, spacing: 0){
                        HStack{
                            Text("Question ")
                            Text("\(actualQuestion.position)")
                                .foregroundColor(Color("vert"))
                                .fontWeight(.heavy)
                            Text("/")
                            Text(questionManager.maxQuestionAff)
                        }
                        .foregroundColor(.white)
                        .modifier(vm_padding(top: 5, trailing: 20, bottom: 5, leading: 20))
                        .modifier(vm_border_r(radius: 8, color: Color("vert"), lineWidth: 3))
                        .background(Color("color2"))
                        .cornerRadius(8)
                        Spacer()
                        
                    }
                    .foregroundColor(Color("color1"))
                    .padding(.leading, 20)
                    .padding(.top, 2)
                    
                    // line break
                    Br(size: 1)
                    //Bolck question
                    VStack{
                        HStack{
                            Spacer()
                            Text("How much is : ")
                                .fontWeight(.bold)
                                .modifier(vm_padding(top: 10, trailing: 30, bottom: 0, leading: 30))
                                .foregroundColor(Color("color1"))
                            Spacer()
                        }
                        HStack(alignment: .center, spacing: 10){
                            RandomAnimal(number: actualQuestion.firstNumber)
                            AskedNumber(number: actualQuestion.firstNumber.description)
                            Text("x").font(.largeTitle)
                                .foregroundColor(.white)
                            AskedNumber(number: actualQuestion.secondNumber.description)
                                .rotation3DEffect(Angle.degrees(rotateValue), axis: (x: 0, y: 1, z: 0))
                            RandomAnimal(number: actualQuestion.secondNumber)
                        }
                            
                        .padding(.bottom, 5)
                    }
                        
                    .background(
                        Color(red: 243/255, green: 186/255, blue: 109/255, opacity: 0.7)
                    )
                        .overlay(
                            Rectangle()
                                .stroke(Color.clear)
                                .shadow(radius: 1)
                    )
                    
                    // Play block
                    HStack(alignment: .top){
                        // Keyboard + display block
                        VStack {
                            // Display
                            HStack{
                                Text(answer)
                                    .frame(width: 170, height: 50, alignment: .center)
                                    .font(.title)
                                    .foregroundColor(Color("color1"))
                                    .background(Color(.white))
                                    .cornerRadius(8)
                                if displayValidButton {
                                    Image("roundWood")
                                        .resizable()
                                        .frame(width:60, height: 60)
                                        .overlay(
                                            Button(action:{
                                                //Valid answer
                                                self.userValidANswer()
                                            }){
                                                Image(systemName: "arrow.up.circle.fill").resizable()
                                                    .frame(width:40, height: 40)
                                                    .foregroundColor(Color("color2"))
                                            }
                                            .frame(width:50, height: 50)
                                    )
                                    
                                }else {
                                    Color.clear
                                        .frame(width:60, height: 60)
                                }
                            }
                                
                            .frame(height:50)
                            .frame(minHeight:50,
                                   idealHeight: 50,
                                   maxHeight: 50)
                                .padding(.bottom, 10)
                            
                            
                            // Keyboard
                            //Line 1 2 3
                            HStack{
                                
                                /* this is a full button without modifiers :
                                 Image("woodPad")
                                 .resizable()
                                 .frame(width: 70, height: 70, alignment: .center)
                                 .overlay(
                                 Button(action: { self.paramVisible = true }) {
                                 Color(.clear)
                                 .overlay(
                                 Text("1")
                                 .foregroundColor(Color.white)
                                 .font(.title)
                                 )
                                 }
                                 
                                 )
                                 */
                                ForEach(1..<4){ num in
                                    Image("woodPad").resizable()
                                        .modifier(vm_pad())
                                        .overlay(
                                            Button(action: { self.padTapped("\(num)") }) {
                                                PadContent(number: "\(num)")
                                            }
                                    )
                                }
                            }
                            //Line 4 5 6
                            HStack {
                                ForEach(4..<7){ num in
                                    Image("woodPad").resizable()
                                        .modifier(vm_pad())
                                        .overlay(
                                            Button(action: { self.padTapped("\(num)") }) {
                                                PadContent(number: "\(num)")
                                            }
                                    )
                                }
                            }
                            
                            //Line 7 8 9
                            HStack {
                                ForEach(7..<10){ num in
                                    Image("woodPad").resizable()
                                        .modifier(vm_pad())
                                        .overlay(
                                            Button(action: { self.padTapped("\(num)") }) {
                                                PadContent(number: "\(num)")
                                            }
                                    )
                                }
                            }
                            // Line 0 + clear
                            HStack {
                                Image("roundWood")
                                    .resizable()
                                    .modifier(vm_pad())
                                    .overlay(
                                        Button(action:{
                                            self.resetInput()
                                        }){
                                            Image(systemName: "delete.left.fill")
                                                .foregroundColor(.white)
                                        }
                                )
                                Image("woodPad")
                                    .resizable()
                                    .modifier(vm_pad())
                                    .overlay(
                                        Button(action:{
                                            self.padTapped("0")
                                        }){
                                            PadContent(number: "0")
                                        }
                                )
                                Text("")
                                    .frame(width:70, height: 50)
                            }
                            .padding(.top, 5)
                            
                        }// End Display and keyboard
                    }// end response block
                    //Spacer()
                    Color.yellow
                }// VStack game without toast
                // .background(Color.blue)
                // Spacer to force game to be at the top
                Spacer()
                
                // toast
                HStack{
                    if goodAnswerToast {
                        HStack{
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color("vert"))
                            Text("Good Answer !")
                                .foregroundColor(.white)
                        }
                        .modifier(vm_toast())
                    }
                    if badAnswerToast {
                        HStack{
                            Text("Bad answer 😅")
                                .foregroundColor(.red)
                            Text("\(actualQuestion.goodAnswer)")
                                .foregroundColor(.white)
                                .bold()
                        }
                        .modifier(vm_toast())
                    } else {
                        HStack{
                            Text(".")
                                .foregroundColor(.clear)
                        }
                    }
                }
                .frame(height: 40)
                .padding(.bottom, 10)
                
                
            }// VStack Main
                
                .foregroundColor(Color("color2"))
                .background(Image("forestBg")
                    .resizable()
                    .scaledToFill()
            )
                
                .alert(isPresented: $showingError){
                    Alert(title: Text("empty answer..."), message: Text("Try to answer before validating"), dismissButton: .default(Text("OK")))
            }
            
            
            
            
            
            
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
