//
//  AnimalImage1.swift
//  Day35-SwiftUI-Challenge
//
//  Created by Ezequiel Parada Beltran on 16/09/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import SwiftUI

struct AnimalImage1: View {
    
    let animal: String
    var body: some View {
        Image(animal)
        .resizable()
            .frame(width: 55, height: 50)
    }
}

struct AnimalImage1_Previews: PreviewProvider {
    static var previews: some View {
        AnimalImage1(animal: "panda")
    }
}
