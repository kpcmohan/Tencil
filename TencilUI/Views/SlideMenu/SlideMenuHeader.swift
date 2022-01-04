//
//  SlideMenuHeader.swift
//  TencilUI
//
//  Created by  on 10/06/21.
//

import SwiftUI

struct SlideMenuHeader: View {
    @Binding var isShowing : Bool
    var body: some View {
        
        ZStack(alignment : .topTrailing ) {
//            Button(action: {
//                withAnimation (.spring()){
//                    isShowing.toggle()
//                }
//            }, label: {
//                HStack {
//                    Image.close
//                        .frame(width: 32, height: 32, alignment: .center)
//                        .foregroundColor(.white)
//                        .padding()
//                }
//                .frame(width: 45, height: 45)
//                
//            })
            VStack(alignment : .leading) {
                Text(String.welcomeTencil)
                    .font(.system(size: 25,weight: .bold))
                    .padding(.horizontal,16)
                Text(String.countrolFuture)
                    .font(.system(size: 15,weight: .medium))
                    .padding([.horizontal],16)
                    
            }.frame(height: 150, alignment: .bottom)
        }
    }
}

struct SlideMenuHeader_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuHeader(isShowing: .constant(true))
    }
}
