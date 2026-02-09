//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Adrian GC on 2/6/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            pegs(colors: [.red, .blue, .green, .yellow])
            pegs(colors: [.red, .blue, .green, .yellow])
            pegs(colors: [.red, .blue, .green, .yellow])
        }
        .padding()
    }
    
    func pegs(colors: Array<Color>) -> some View {
        HStack {
            ForEach(colors.indices, id: \.self ){ index in
                Circle()
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundColor(colors[index])
            }
            MatchMarkers(matches: [.exact, .inexact, .nomatch, .exact])
        }
    }
}

#Preview {
    ContentView()
}
