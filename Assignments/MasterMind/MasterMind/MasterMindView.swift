//
//  MasterMindView.swift
//  MasterMind
//
//  Created by Adrian GC on 2/9/26.
//

import SwiftUI

struct MasterMindView: View {
    @State var game = MasterMindModel(pegChoices: [.blue, .green, .red, .yellow])
    
    var body: some View {
        VStack {
            view(for: game.masterCode)
            ScrollView {
                view(for: game.guess)
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
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
        game = MasterMindModel(pegChoices: [.blue, .green, .red, .yellow])
    }

    func view(for code: Code) -> some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self){ index in
                Circle()
                    .overlay {
                        if code.pegs[index] == Code.missing {
                            Circle()
                                .strokeBorder(Color.gray)
                        }
                    }
                    .contentShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundColor(code.pegs[index])
                    .onTapGesture {
                        if code.kind == .guess {
                            game.changeGuessPeg(at: index)
                        }
                    }
            }
            MatchMarkers(matches: code.matches)
                .overlay {
                    if code.kind == .guess {
                        guessButton
                    }
                }
        }
    }
}

#Preview {
    MasterMindView()
}
