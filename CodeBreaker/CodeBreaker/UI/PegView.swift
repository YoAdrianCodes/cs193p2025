//
//  SwiftUIView.swift
//  CodeBreaker
//
//  Created by Adrian GC on 2/16/26.
//

import SwiftUI

struct PegView: View {
    // MARK: Data IN
    var peg: Peg
    
    // MARK: - Body
    var body: some View {
        Circle()
            .overlay {
                if peg == Code.missingPeg {
                    Circle()
                        .strokeBorder(Color.gray)
                }
            }
            .contentShape(Circle())
            .aspectRatio(1, contentMode: .fit)
            .foregroundColor(peg)
    }
}

#Preview {
    PegView(peg: .blue)
}
#Preview {
    PegView(peg: .missingPeg)
}
