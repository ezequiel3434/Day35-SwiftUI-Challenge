//
//  vm_border_r.swift
//  Day35-SwiftUI-Challenge
//
//  Created by Ezequiel Parada Beltran on 16/09/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import SwiftUI

struct vm_border_r: ViewModifier {
    
    let radius: CGFloat
    let color: Color
    let lineWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
        .overlay(
            RoundedRectangle(cornerRadius: radius)
            .stroke(color, lineWidth: lineWidth)
        )
        
    }
}


