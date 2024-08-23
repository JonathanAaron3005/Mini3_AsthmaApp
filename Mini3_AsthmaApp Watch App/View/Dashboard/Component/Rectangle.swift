//
//  Rectangle.swift
//  Mini3_AsthmaApp Watch App
//
//  Created by Kevin Fairuz on 23/08/24.
//

import SwiftUI

struct RectangleCom: View {
    var body: some View {
        Rectangle()
            .cornerRadius(12)
            .frame(width: 158, height: 53)
            .foregroundColor(Color.black.opacity(0.2))   
    }
}
