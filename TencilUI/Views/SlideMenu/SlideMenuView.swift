//
//  SlideMenuView.swift
//  TencilUI
//
//  Created by on 10/06/21.
//

import SwiftUI

struct SlideMenuView: View {
    @Binding var isShowing : Bool
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.slideMenuC, Color.white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(alignment : .leading){
                SlideMenuHeader(isShowing: $isShowing)
                    .foregroundColor(.white)
                SlideMenuItems()
                    .background(Color.white)
                Spacer()
            }
        }.navigationBarHidden(true)
    }
}

struct SlideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuView(isShowing: .constant(true))
    }
}
