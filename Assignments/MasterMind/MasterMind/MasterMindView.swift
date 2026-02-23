//
//  MasterMindView.swift
//  MasterMind
//
//  Created by Adrian GC on 2/9/26.
//

import SwiftUI

struct MasterMindView: View {
    @State private var game = MasterMindModel(pegChoices: [.red, .yellow, .blue, .green])
    @State private var selection = 0
    
    var body: some View {
        VStack {
            ScrollView {
                view(for: game.masterCode)
                if !game.isOver {
                    view(for: game.guess)
                }
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
            PegChooser(choices: game.pegChoices){ peg in
                game.setGuessPeg(peg, at: selection)
                selection = (selection + 1) % game.masterCode.pegs.count
            }
            restartButton
        }
        .padding()
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
        }
        .font(.system(size: 80))
        .minimumScaleFactor(0.1)
    }

    var restartButton: some View {
        Button("Restart Game"){
            restart()
        }
        .font(.system(size: 25))
    }
    
    func restart(){
        game = MasterMindModel(pegChoices: [.red, .yellow, .blue, .green])
    }

    func view(for code: Code) -> some View {
        HStack {
            CodeView(code: code, selection: $selection)
            Rectangle().foregroundColor(Color.clear).aspectRatio(contentMode: .fit)
                .overlay {
                    if let matches = code.matches {
                        MatchMarkers(matches: matches)
                    } else {
                        if code.kind == .guess {
                            guessButton
                        }
                    }
                }
        }
    }
}

#Preview {
    MasterMindView()
}
