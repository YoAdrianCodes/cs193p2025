//
//  PegChooser.swift
//  MasterMind
//
//  Created by Adrian GC on 2/18/26.
//

import SwiftUI

struct PegChooser: View {
    var choices: [Peg]
    let onChoose: ((Peg) -> Void)?
    
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
