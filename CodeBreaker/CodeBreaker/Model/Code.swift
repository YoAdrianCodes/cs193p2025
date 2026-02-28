//
//  Code.swift
//  CodeBreaker
//
//  Created by Adrian GC on 2/23/26.
//

struct Code {
    static var missingPeg: Peg = .clear
    var kind: Kind
    var pegs: [Peg] = Array(repeating: Peg.missingPeg, count: 4)
    
    var isHidden: Bool {
        switch kind {
        case .master(let isHidden): return isHidden
        default: return false
        }
    }

    var matches: [Match]? {
        switch self.kind {
        case .attempt(let matches): return matches
        default: return nil
        }
    }
    
    enum Kind: Equatable {
        case master(isHidden: Bool)
        case guess
        case attempt([Match])
        case unknown
    }
    
    mutating func randomize(from pegChoices: [Peg]) {
        for index in pegChoices.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missingPeg
        }
        print(self)
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
    
    mutating func reset() {
        pegs = Array(repeating: Peg.missingPeg, count: 4)
    }
}
