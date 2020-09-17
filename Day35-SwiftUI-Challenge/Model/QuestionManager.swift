//
//  QuestionManager.swift
//  Day35-SwiftUI-Challenge
//
//  Created by Ezequiel Parada Beltran on 14/09/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import Foundation

struct QuestionManager {
    var maximunQuestion = "10"
    var table: Int = 3
    
    var maxQuestionAff: String {
        
        return self.maximunQuestion != "all" ? self.maximunQuestion: "10"
    }
    
    var maxQuestionInt: Int {
        switch maximunQuestion {
        case "5":
            return 5
        case "10":
            return 10
        case "20":
            return 20
        case "all":
            return 10
        default:
            return 10
        }
    }
    
    // Score
    var score: Int {
        let tabTrueAnswers = self.tabQuestion.filter(\.wellAnswerd)
        
        return tabTrueAnswers.count
    }
    
    var tabQuestion: [Question] = []  // array which will contain all the questions
    var actualQuestionPosition = 0  // Position of the current question
    
    
    // Starting a game
    
    mutating func newGame(nbQuestions: String, table: Int, then: (Question) -> Void) {
        
        // Initialization
        self.maximunQuestion = nbQuestions
        self.table = table
        self.actualQuestionPosition = 0
        self.tabQuestion.removeAll()
        
        
        var tabMultiplesPossibles = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        if nbQuestions != "all" {
            // Loop 1 on the number of questions
            for number in 1...maxQuestionInt {
                // if the person wants 20 questions, we reload the array with 10 new digits (will avoid repetition)
                if (number == 10  && nbQuestions == "20") {
                    tabMultiplesPossibles += [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                }
                // The question will consist of the number from the table first, and a random number second
                // We find a random number
                let randomNumber = tabMultiplesPossibles.randomElement()
                
                if let rndNumber = randomNumber {
                    // we locate the position of the random number obtained, in the table of possible multiples (to be able to delete it)
                    if let indexNumb = tabMultiplesPossibles.firstIndex(of: rndNumber) {
                        // We remove it from the table
                        tabMultiplesPossibles.remove(at: indexNumb)
                        let question = Question(firstNumber: table, secondNumber: rndNumber, position: number)
                        // We have our question, just put it in the questions table
                        tabQuestion.append(question)
                    }
                } else {
                    // default behavior if there were more numbers in the table
                    let question = Question(firstNumber: table, secondNumber: 1, position: number)
                    tabQuestion.append(question)
                }
            }
        }
        // "All" case
        else {
            for number in 1...10 {
                let question = Question(firstNumber: table, secondNumber: number, position: number)
                tabQuestion.append(question)
            }
        }
        
        let question = self.getActualQuestion()
        
        // Closure that will return the first question
        
        then(question)
    }
    
    func getActualQuestion() -> Question {
        // return the current question
        return self.tabQuestion[actualQuestionPosition]
    }
    
    mutating func nextQuestion(){
        // we move on to the next question if the maximum number of questions allows it
        
        if actualQuestionPosition + 1 < maxQuestionInt {
            actualQuestionPosition += 1
        }
    }
}

