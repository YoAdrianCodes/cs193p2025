//
//  PegView.swift
//  MasterMind
//
//  Created by Adrian GC on 2/18/26.
//

import SwiftUI

struct PegView: View {
    var peg: Peg
    
    var body: some View {
        Circle()
            .overlay {
                if peg == Code.missing {
                    Circle()
                        .strokeBorder(Color.gray)
                }
            }
            .contentShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .aspectRatio(contentMode: .fit)
            .foregroundColor(peg)
    }
}

//#Preview {
//    PegView()
//}
