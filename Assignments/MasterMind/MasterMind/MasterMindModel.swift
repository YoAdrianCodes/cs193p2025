//
//  MasterMindModel.swift
//  MasterMind
//
//  Created by Adrian GC on 2/12/26.
//
import SwiftUI

typealias Peg = Color

struct MasterMindModel {
    var masterCode: Code = Code(kind: .master(isHidden: true))
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = [Code]()
    var pegChoices: [Peg]
    
    var isOver: Bool {
        attempts.last?.pegs == masterCode.pegs
    }
    
    init(pegChoices: [Peg]){
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
        print(masterCode)
    }
    
    mutating func attemptGuess(){
        var attempt = guess
        let missingCount = attempt.pegs.filter { $0 == Code.missing}.count
        let pastPegAttempts = attempts.map { $0.pegs }
        let duplicateGuess: Bool = pastPegAttempts.contains(guess.pegs)
        if missingCount == 0 && duplicateGuess != true {
            attempt.kind = .attempt(guess.match(against: masterCode))
            attempts.append(attempt)
        }
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
            guess.pegs[index] = pegChoices.first ?? Code.missing
        }
    }
    
    mutating func setGuessPeg(_ peg: Peg, at index: Int){
        guard guess.pegs.indices.contains(index) else { return }
        guess.pegs[index] = peg
    }
}

struct Code {
    static var missing = Peg.clear
    var kind: Kind
    var pegs: [Peg] = Array(repeating: Code.missing, count: 4)
    
    var isHidden: Bool {
        switch kind {
        case .master(let isHidden): return isHidden
        default: return false
        }
    }
    
    enum Kind: Equatable {
        case master(isHidden: Bool)
        case attempt([Match])
        case guess
        case unknown
    }
    
    var matches: [Match]? {
        switch kind {
        case .attempt(let matches): return matches
        default: return nil
        }
    }
    
    mutating func randomize(from pegChoices: [Peg]){
        for index in pegChoices.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missing
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        var pegsToMatch = otherCode.pegs
        
        let backwardsExactMatches = pegs.indices.reversed().map { index in
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                pegsToMatch.remove(at: index)
                return Match.exact
            } else {
                return .nomatch
            }
        }
        
        let exactMatches = Array(backwardsExactMatches.reversed())
        return pegs.indices.map { index in
            if exactMatches[index] != .exact, let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                pegsToMatch.remove(at: matchIndex)
                return .inexact
            } else {
                return exactMatches[index]
            }
        }
    }
    
    mutating func reset(){
        pegs = Array(repeating: Code.missing, count: 4)
    }
}
