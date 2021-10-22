//
//  ActivityView.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 10/22/21.
//

import SwiftUI

struct ActivityView: View {
    @State var isAnimating = false
    
    var body: some View {
        ZStack {
          Color.whiteLiliac
                
            Circle()
                .trim(from: 0.3, to: 1)
            
            .stroke(
              Color.sanMarino,
              style: StrokeStyle(
                lineWidth: 5,
                lineCap: .round
              )
            )
            .frame(width: 40, height: 40)
            .rotationEffect(.degrees(isAnimating ? 360 : 0))
            .animation(
                .linear(duration: 1)
                .repeatForever(autoreverses: false))

        }
          .frame(width: 80, height: 80)
          .background(Color.white)
          .modifier(NeomorphicInnerShadow(shape: Capsule(style: .continuous)))
          .clipShape(Capsule(style: .continuous))
          .onAppear {
              isAnimating = true
          }
          .onDisappear {
              isAnimating = false
          }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
