//
//  ContentView.swift
//  VariousUI
//
//  Created by Bear Cahill on 9/14/20.
//

import SwiftUI

extension AnyTransition {
    static var textTransition : AnyTransition {
            AnyTransition
                .asymmetric(
                    insertion: AnyTransition
                        .opacity
                        .combined(with:
                            .move(edge: .top)),
                    removal: .slide)
        }

}

struct BouncyModifier : ViewModifier {
    var blurFactor : CGFloat

    func body(content: Content) ->  some View {
        return content
            .shadow(radius: blurFactor > 0 ? 10 : 50)
            .scaleEffect(blurFactor > 0 ? 0.5 : 1.0)
            .animation(
                .spring(dampingFraction : 0.15))
            .blur(radius: blurFactor)

    }

}

extension View {
    func bouncy(blurFactor: CGFloat)
        -> some View {
        self.modifier(
            BouncyModifier(blurFactor: blurFactor))

   }

}

struct ContentView: View {
    @State var isToggled = false
    let gradient = Gradient(colors:
        [.purple, .yellow, .green])

    var body: some View {
        let radialGradient = RadialGradient(gradient:                         gradient,
                          center: .center,
                          startRadius: 1.0,
                          endRadius: 250.0)
        let angularGradient = AngularGradient(gradient:
                  gradient,
                  center: .center,
                  angle: .degrees(0))
        VStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 1)) {
                    self.isToggled.toggle()
                }
                   }) {
                        Text("Toggle")
                    }
            if isToggled {
                Text("Toggled")
                    .transition(.textTransition)
            }
            VStack {
                ForEach(0..<10, id: \.self) { index in
                    HStack {
                        ForEach(0..<10, id: \.self) { index2 in
                            Circle()
                                .fill(angularGradient)
                                .bouncy(blurFactor:
                                self.isToggled ? 5 : 0)
                                .rotation3DEffect(Angle(degrees:
                                    self.isToggled ? 300 : 0),
                                    axis: (x: 1, y: 1, z: 1))
                                .animation(.linear(duration:
                                        0.75))
                        }
                    }
                }
            }.drawingGroup()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
