//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Adrian GC on 2/6/26.
//

import SwiftUI

struct CodeBreakerView: View {
    // MARK: Data Owned by me
    @State private var game = CodeBreaker(pegChoices: [.blue, .yellow, .green, .red])

    @State private var selection: Int = 0
    @State private var restarting: Bool = false
    @State private var hideMostRecentMarkers = false
    
    var body: some View {
        VStack {
            Button("Restart", systemImage: "arrow.circlepath", action: restart)
            CodeView(code: game.masterCode, ancillaryView: {
                Text("0:03").font(.title)
            })
            ScrollView {
                if !game.isOver || restarting {
                    CodeView(code: game.guess, selection: $selection){
                        Button("Guess", action: guess)
                            .flexibleSystemFont(minimum: 10)
                    }
                    .animation(nil, value: game.attempts.count)
                    .opacity(restarting ? 0 : 1)
                }
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    CodeView(code: game.attempts[index]){
                        let showMarkers = !hideMostRecentMarkers || index != game.attempts.count - 1
                        if showMarkers, let matches = game.attempts[index].matches {
                            MatchMarkers(matches: matches)
                        }
                    }
                    .transition(.attempt(game.isOver))
                }
            }
            if !game.isOver {
                PegChooser(choices: game.pegChoices, onChoose: changePegAtSelection)
                    .transition(.pegChooser)
            }
        }
        .padding()
    }
    
    func changePegAtSelection(peg: Peg){
        game.setGuessPeg(peg, at: selection)
        selection = (selection + 1) % game.masterCode.pegs.count
    }
    
    func guess() {
        withAnimation(Animation.guess) {
            game.attemptGuess()
            selection = 0
            hideMostRecentMarkers = true
        } completion: {
            withAnimation(.guess){
                hideMostRecentMarkers = false
            }
        }
    }
    
    func restart() {
        withAnimation(.restart){
            restarting = true
        } completion: {
            withAnimation(.restart) {
                game.restart()
                selection = 0
                restarting = false
            }
        }
    }
}

#Preview {
    CodeBreakerView()
}
