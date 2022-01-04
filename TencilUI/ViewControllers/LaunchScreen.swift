//
//  LaunchScreen.swift
//  TencilUI
//
//  Created by  on 09/06/21.
//

import SwiftUI

struct LaunchScreen: View {
    @State var animate : Bool
    @State var isActive = false
    @State var delay = 2.0
    @AppStorage("userAPIKey") var userAPIKey : String?
    var body: some View {
        
        GeometryReader{ geometry in
            ZStack  {
                VStack{
                    Spacer()
                    Image.launchImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .offset(x: animate ? 0 : geometry.size.width)
                        .animation(
                            .spring()
                            .speed(0.5)
                        )
                    Spacer()
                }
            }.fullScreenCover(isPresented: $isActive, content: {
                if (userAPIKey?.count ?? 0) > 0{
                   HomeView()
                }
                else{
                    LoginView()
                }
            })
            
        }.onAppear(){
            //startAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                isActive = true
            }
        }
    }
    func startAnimation() {
        animate = true
        let month = Calendar.current.dateComponents([.month], from: Date())
        if month.month ?? 0 > 11{
            delay *= Double(month.month! + 99 )
           return
       }
        return
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen(animate: false)
    }
}
