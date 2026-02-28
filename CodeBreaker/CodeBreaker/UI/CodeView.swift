//
//  CodeView.swift
//  CodeBreaker
//
//  Created by Adrian GC on 2/17/26.
//

import SwiftUI

struct CodeView<AncillaryView>: View where AncillaryView: View {
    // MARK: Data In
    var code: Code
    
    // MARK: Data Shared With Me
    @Binding var selection: Int
    
    @ViewBuilder let ancillaryView: () -> AncillaryView
    
    // MARK: Data owned by me
    @Namespace private var selectionNamespace
    
    init(
        code: Code,
        selection: Binding<Int> = Binding<Int>.constant(-1),
        @ViewBuilder ancillaryView: @escaping () -> AncillaryView = { EmptyView() }
    ) {
        self.code = code
        self._selection = selection
        self.ancillaryView = ancillaryView
    }
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self ){ index in
                PegView(peg: code.pegs[index])
                    .padding(Selection.border)
                    .background { // selection background
                        Group {
                            if selection == index, code.kind == .guess {
                                RoundedRectangle(cornerRadius: Selection.cornerRadius)
                                    .foregroundColor(Selection.color)
                                    .matchedGeometryEffect(id: "selection", in: selectionNamespace)
                            }
                        }
                        .animation(.selecting, value: selection)
                    }
                    .overlay {
                        Selection.shape
                            .foregroundStyle(code.isHidden ? Color.gray : .clear)
                            .transaction { transaction in
                                if code.isHidden {
                                    transaction.animation = nil
                                }
                                
                            }
                    }
                    .onTapGesture {
                        if code.kind == .guess {
                            selection = index
                        }
                    }
            }
            Rectangle().foregroundStyle(Color.clear).aspectRatio(contentMode: .fit)
                .overlay {
                    ancillaryView()
                }
        }
    }
}

fileprivate struct Selection {
    static let border: CGFloat = 5
    static let cornerRadius: CGFloat = 10
    static let color: Color = Color.gray(0.85)
    static let shape = RoundedRectangle(cornerRadius: cornerRadius)
}

//#Preview {
//    CodeView()
//}
