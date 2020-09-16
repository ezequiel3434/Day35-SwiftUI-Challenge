//
//  PadContent.swift
//  Day35-SwiftUI-Challenge
//
//  Created by Ezequiel Parada Beltran on 16/09/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import SwiftUI

struct PadContent: View {
    
    let number: String
    
    var body: some View {
        Color(.clear)
            .overlay(
                Text(number)
                    .foregroundColor(Color.white)
                    .font(.title)
        )
    }
}

struct PadContent_Previews: PreviewProvider {
    static var previews: some View {
        
        Image("woodPad").resizable()
            .modifier(vm_pad())
            .overlay(
                Button(action: {}){
                    PadContent(number: "1")
                }
        )
        
    }
}
