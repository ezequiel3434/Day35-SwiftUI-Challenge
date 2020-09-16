//
//  RandomAnimal.swift
//  Day35-SwiftUI-Challenge
//
//  Created by Ezequiel Parada Beltran on 16/09/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import SwiftUI

struct RandomAnimal: View {
    
    let number: Int
    let animals = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "duck",
    "elephant", "frog", "goat", "gorilla", "hippo", "horse", "monkey", "moose", "narwhal",
    "owl", "panda", "parrot", "penguin", "pig", "rabbit", "rhino", "sloth", "snake", "walrus", "whale", "zebra"]
    
    var body: some View {
        HStack{
            if number <= 29 {
                Image(animals[number])
                .resizable()
                    .frame(width: 50, height: 55)
            }
        }
    }
}

struct RandomAnimal_Previews: PreviewProvider {
    static var previews: some View {
        RandomAnimal(number: 3)
    }
}
