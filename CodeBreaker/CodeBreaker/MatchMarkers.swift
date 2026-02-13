//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by Adrian GC on 2/6/26.
//

import SwiftUI


enum Match {
    case exact
    case inexact
    case nomatch
    
}
//inexact meaning, right color wrong positioning

struct MatchMarkers: View {
    // data in
    let matches: [Match]
    
    var body: some View {
            HStack {
                VStack {
                    matchMarker(peg: 0)
                    matchMarker(peg: 1)
                }
                VStack {
                    matchMarker(peg: 2)
                    matchMarker(peg: 3)
                }
                
            }
        }
    
    func matchMarker(peg: Int) -> some View {
        let exactCount = matches.filter{ $0 == .exact}.count
        let foundCount  = matches.filter{ $0 != .nomatch}.count
        return Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2).aspectRatio(1, contentMode:  .fit)
            
    }

}

#Preview {
    MatchMarkers(matches: [.exact, .inexact, .inexact, .exact])
}
