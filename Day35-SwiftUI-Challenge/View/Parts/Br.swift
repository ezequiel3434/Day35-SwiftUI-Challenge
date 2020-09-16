//
//  Br.swift
//  Day35-SwiftUI-Challenge
//
//  Created by Ezequiel Parada Beltran on 16/09/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import SwiftUI

struct Br: View {
    
    let size: Int
    
    var body: some View {
        Text("")
            .padding(.top, CGFloat(size))
    }
}

struct Br_Previews: PreviewProvider {
    static var previews: some View {
        Br(size: 10)
    }
}
