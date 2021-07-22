//
//  StaticCardView.swift
//  TencilUI
//
//  Created by  on 10/06/21.
//

import SwiftUI

struct StaticCardView: View {
    @State var title : String
    @State var description : String
    @State var width : CGFloat
    var body: some View {
        VStack(alignment : .center){
            Text(title)
                .font(.system(size: 26,weight: .thin))
                .padding(.bottom,5)
            Text(description)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
                .lineSpacing(3)
        }.frame(width: width, height: 300, alignment: .center)
        .cornerRadius(20)
        .padding()
        .background(Color.staticCVBGC.opacity(0.5))
    }
}

struct StaticCardView_Previews: PreviewProvider {
    static var previews: some View {
        StaticCardView(title: "ALL FEATURED COMPANIES", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", width: 300)
    }
}
