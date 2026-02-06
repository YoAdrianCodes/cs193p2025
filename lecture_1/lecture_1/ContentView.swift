//
//  ContentView.swift
//  lecture_1
//
//  Created by Adrian GC on 2/5/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(content: viewFunc)
        .padding()
    }
}

@ViewBuilder
func viewFunc() -> some View {
    Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
    Text("Hello, world!")
}

#Preview {
    ContentView()
}
