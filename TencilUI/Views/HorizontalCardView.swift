//
//  HorizontalCardView.swift
//  TencilUI
//
//  Created by Manu Puthoor on 10/06/21.
//

import SwiftUI

struct HorizontalCardView: View {
    @State var title : String
    @State var width : CGFloat
    @State var showImage : Bool
    @State var bgColor : String
    
    var body: some View {
        VStack(alignment : .center){
            HStack {
                Text(title)
                    .font(.system(size: 32,weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.bottom,5)
                
                Spacer()
            }
            if showImage{
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80, alignment: .center)
                    .foregroundColor(.black)
                    .font(.system(size: 16,weight: .thin))
            }
           
                
            Spacer()
        }.frame(width: width, height: 180, alignment: .center)
        .cornerRadius(20)
        .padding()
        .background(Color(bgColor))
        
        
    }
}

struct HorizontalCardView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalCardView(title: "Title", width: 320, showImage: true, bgColor: "HCardBG")
    }
}
