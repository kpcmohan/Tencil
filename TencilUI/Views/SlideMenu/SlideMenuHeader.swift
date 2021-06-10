//
//  SlideMenuHeader.swift
//  TencilUI
//
//  Created by Manu Puthoor on 10/06/21.
//

import SwiftUI

struct SlideMenuHeader: View {
    @Binding var isShowing : Bool
    var body: some View {
        
        ZStack(alignment : .topTrailing ) {
            Button(action: {
                withAnimation (.spring()){
                    isShowing.toggle()
                }
            }, label: {
                Image(systemName: "xmark")
                    .frame(width: 32, height: 32, alignment: .center)
                    .foregroundColor(.white)
                    .padding()
            })
            VStack(alignment : .leading) {
                Text("Welcome To Tencil")
                    .font(.system(size: 30,weight: .bold))
                    .padding(.horizontal,16)
                Text("Control Your Future")
                    .font(.system(size: 20,weight: .medium))
                    .padding([.horizontal],16)
                    .padding(.top,5)
            }.frame(height: 150, alignment: .bottom)
        }
    }
}

struct SlideMenuHeader_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuHeader(isShowing: .constant(true))
    }
}
