//
//  Petals.swift
//  Breatheee Watch App
//
//  Created by Kevin Fairuz on 18/08/24.
//

import SwiftUI

// Gradient and Mask Gradient Def
// Create the gradient
let gradient = LinearGradient(gradient: Gradient(colors: [blueCyan]), startPoint: .top, endPoint: .bottom)

// Create the mask gradient
let maskGradient = LinearGradient(gradient: Gradient(colors: [blueCyan.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
let blueCyan = Color(hex: "3DD5D5")

//Animation Parameters
let maxSize: CGFloat = 80
let minSize: CGFloat = 30
let inhaleTime: Double = 2
let exhaleTime: Double = 4
let pauseTime: Double = 1

// Petal Configuration
let  numberOfPetals = 4
let bigAngle = 360.0 / Double(numberOfPetals)
let  smallAngle = bigAngle / 2

// Ghosting Effect Param
let ghostMaxSize: CGFloat = maxSize * 0.99
let ghostMinSize: CGFloat = maxSize * 0.95

struct Petals: View {
    let size: CGFloat
    let inhaling: Bool
    var isMask = false
    
    var body: some View {
        let petalGradient = isMask ? maskGradient : gradient
        ZStack{
            ForEach(0 ..< numberOfPetals) { index in
                petalGradient
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .mask(
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: size, height: size)
                            .offset(x: inhaling ? size * 0.5 : 0)
                            .rotationEffect(.degrees(Double(bigAngle * Double(index))))
                    )
                    .blendMode(isMask ? .normal : .screen)
            }
        }
    }
}

