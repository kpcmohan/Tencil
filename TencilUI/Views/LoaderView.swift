//
//  LoaderView.swift
//  TencilUI
//
//  Created by Manu Puthoor on 26/06/21.
//

import SwiftUI

struct LoaderView: View {
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                Loader()
                    .alignmentGuide(VerticalAlignment.center, computeValue: { $0[.bottom] })
                                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            })
        }).background(Color.black.opacity(0.6))
        .ignoresSafeArea()
    }
}
struct Loader : View {
    @State var animate = false
    var body: some View {
        VStack{
            
            
            Group {
                Circle()
                    .trim(from: 0.0, to: 0.8)
                    .stroke(AngularGradient(gradient: .init(colors: [.orange,.orange]), center: .center), style : StrokeStyle(lineWidth: 8, lineCap: .round))
                    .frame(width: 30, height: 30, alignment: .center)
                    .rotationEffect(.init(degrees: self.animate ? 360 : 0))
                    .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x: 1, y: 1)
                    .padding()
                Text(String.activityIndicatorText)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .padding(.horizontal)
        }
        .padding()
        .onAppear{
            animate.toggle()
        }
    }
}
struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
            .preferredColorScheme(.dark)
    }
}
