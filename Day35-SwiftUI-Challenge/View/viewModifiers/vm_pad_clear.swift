//
//  vm_pad_clear.swift
//  Day35-SwiftUI-Challenge
//
//  Created by Ezequiel Parada Beltran on 16/09/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import SwiftUI

struct vm_pad_clear: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(width: 70, height: 50, alignment: .center)
            .background(Color("vertLight1"))
            .foregroundColor(.white)
            .cornerRadius(8)
    }
    
}


