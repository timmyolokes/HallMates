//
//  GradientView.swift
//  HallMates
//
//  Created by Adeoluwa Olokesusi on 5/15/24.
//

import SwiftUI

struct GradientView: View {
    var startColor: Color
    var endColor: Color
    var startPoint: UnitPoint
    var endPoint: UnitPoint
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: startPoint, endPoint: endPoint)
            .ignoresSafeArea()    }
}

#Preview {
    GradientView(startColor: Color("Yellowish"), endColor: Color("Pinkish"), startPoint: .leading, endPoint: .trailing)}
