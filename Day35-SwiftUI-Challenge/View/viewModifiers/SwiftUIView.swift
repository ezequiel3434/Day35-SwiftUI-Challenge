//
//  SwiftUIView.swift
//  Day35-SwiftUI-Challenge
//
//  Created by Ezequiel Parada Beltran on 16/09/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import SwiftUI

struct vm_toast: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height:40)
            .padding(.leading, 30).padding(.trailing, 30)
            .background(Color("color2"))
            .cornerRadius(8)
    }
}


