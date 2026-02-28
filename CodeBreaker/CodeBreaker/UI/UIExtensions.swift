//
//  UIExtensions.swift
//  CodeBreaker
//
//  Created by Adrian GC on 2/26/26.
//
import SwiftUI

extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        return Color(hue: 148/360, saturation: 0, brightness: brightness)
    }
}

extension Animation {
    static let codeBreaker = Animation.easeInOut(duration: 3)
    static let restart = Animation.codeBreaker
    static let guess = Animation.codeBreaker
    static let selecting = Animation.codeBreaker
}

extension AnyTransition {
    static var pegChooser = AnyTransition.offset(x: 0, y: 200)
    static func attempt(_ isOver: Bool) -> AnyTransition {
        AnyTransition.asymmetric(insertion: isOver ? .opacity : .move(edge: .top), removal: .move(edge: .trailing))
    }
}

extension View {
    func flexibleSystemFont(minimum: CGFloat = 8, maximum: CGFloat = 80) -> some View {
        self
        .font(.system(size: maximum))
        .minimumScaleFactor(minimum/maximum)
    }
}
