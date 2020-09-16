//
//  vm_padding.swift
//  Day35-SwiftUI-Challenge
//
//  Created by Ezequiel Parada Beltran on 16/09/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import SwiftUI

struct vm_padding: ViewModifier {
    
    let top: CGFloat
    let trailing: CGFloat
    let bottom: CGFloat
    let leading: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(.top, top)
            .padding(.trailing, trailing)
            .padding(.bottom, bottom)
            .padding(.leading, leading)
    }
}

