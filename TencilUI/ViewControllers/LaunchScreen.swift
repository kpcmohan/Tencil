//
//  LaunchScreen.swift
//  TencilUI
//
//  Created by Manu Puthoor on 09/06/21.
//

import SwiftUI

struct LaunchScreen: View {
    @State var animate : Bool
    @State var isActive = false
    var body: some View {
        
        GeometryReader{ geometry in
            ZStack  {
                VStack{
                    Spacer()
                    
                    Image("launchImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .offset(x: animate ? 0 : geometry.size.width)
                        .animation(
                            .spring()
                            .speed(0.5)
                        )
                    Spacer()
                    Text("Powered by Providence Web Services")
                    Text("version 1.1.19")
                        .padding(1)
                }
            }.fullScreenCover(isPresented: $isActive, content: {
                LoginView()
            })
            
        }.onAppear(){
            startAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                isActive = true
            }
        }
    }
    func startAnimation() {
        animate = true
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen(animate: false)
    }
}
