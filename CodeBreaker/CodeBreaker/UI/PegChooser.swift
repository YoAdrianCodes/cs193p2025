//
//  PegChooser.swift
//  CodeBreaker
//
//  Created by Adrian GC on 2/17/26.
//

import SwiftUI

struct PegChooser: View {
    
    // MARK: Data In
    var choices: [Peg]
    
    // MARK: Data Out
    let onChoose: ((Peg) -> Void)?
    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(choices, id: \.self){ peg in
                Button {
                    onChoose?(peg)
                } label: {
                    PegView(peg: peg)
                }
            }
        }
    }
}

//#Preview {
//    PegChooser()
//}
