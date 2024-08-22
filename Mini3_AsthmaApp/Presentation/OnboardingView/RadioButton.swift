//
//  SwiftUIView.swift
//  Mini3Demo
//
//  Created by Bintang Anandhiya on 17/08/24.
//

import SwiftUI

struct RadioButton: View {
    @Binding private var isSelected: Bool
    private let label: String
    
    init<V: Hashable>(tag: V, selection: Binding<V?>, label: String = "") {
        self._isSelected = Binding(
            get: { selection.wrappedValue == tag },
            set: { _ in selection.wrappedValue = tag }
        )
        self.label = label
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
//            circleView
            symbolView
            labelView
        }
        .contentShape(Rectangle())
        .onTapGesture { isSelected = true }
    }
}

private extension RadioButton {
    @ViewBuilder var labelView: some View {
        if !label.isEmpty { // Show label if label is not empty
            Text(label)
        }
    }
    
    @ViewBuilder var circleView: some View {
        Circle()
            .fill(innerCircleColor) // Inner circle color
            .padding(4)
            .overlay(
                Circle()
                    .stroke(outlineColor, lineWidth: 1)
            ) // Circle outline
            .frame(width: 20, height: 20)
    }
    
    @ViewBuilder var symbolView: some View {
        Image(systemName: isSelected ? "circle.circle.fill" : "circle")
            .font(.title3)
            .transformEffect(.init(translationX: 0, y: 1))
            .frame(width: 20, height: 20)
    }
}


private extension RadioButton {
    var innerCircleColor: Color {
        return isSelected ? Color.blue : Color.clear
    }
    
    var outlineColor: Color {
        return isSelected ? Color.blue : Color.gray
    }
}

//#Preview {
//    SwiftUIView()
//}
