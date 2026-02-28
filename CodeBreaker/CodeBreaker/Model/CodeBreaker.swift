//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Adrian GC on 2/9/26.
//

import Foundation
import SwiftUI

extension Peg {
    static var missingPeg = Color.clear
}

typealias Peg = Color

struct CodeBreaker {
    var masterCode: Code = Code(kind: .master(isHidden: true))
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = [Code]()
    var pegChoices: [Peg]
    
    var isOver: Bool {
        attempts.last?.pegs == masterCode.pegs
    }
    
    init(pegChoices: [Peg]){
        masterCode.randomize(from: pegChoices)
        self.pegChoices = pegChoices
    }
    
    mutating func restart(){
        masterCode.kind = .master(isHidden: true)
        masterCode.randomize(from: pegChoices)
        guess.reset()
        attempts.removeAll()
    }

    mutating func attemptGuess(){
        var attempt = guess
        attempt.kind = .attempt(guess.match(against: masterCode))
        attempts.append(attempt)
        guess.reset()
        if isOver {
            masterCode.kind = .master(isHidden: false)
        }
    }
    
    mutating func changeGuessPeg(at index: Int){
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg) {
            let newPeg = pegChoices[(indexOfExistingPegInPegChoices + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        } else {
            guess.pegs[index] = pegChoices.first ?? Code.missingPeg
        }
    }
    
    mutating func setGuessPeg(_ peg: Peg, at index: Int){
        guard guess.pegs.indices.contains(index) else { return }
        guess.pegs[index] = peg
    }
}
