//
//  CustomButton.swift
//  Mini3_AsthmaApp
//
//  Created by Jonathan Aaron Wibawa on 20/08/24.
//

import SwiftUI

struct CustomButton: View {
    var text: String
    var color: Color
    var image: String?
    
    var body: some View {
        HStack {
            Image(systemName: image ?? "")
            Text(text)
        }
        .fontWeight(.bold)
        .frame(maxWidth: .infinity)
        .padding(17)
        .background(color)
        .foregroundStyle(color == .black.opacity(0.88) ? .white : .black)
        .cornerRadius(25)
    }
}

#Preview {
    CustomButton(text: "test", color: .black.opacity(0.88), image: "pause.fill")
}
