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
                .font(.system(size: 25))
                .padding(.bottom,5)
            Text(description)
                .foregroundColor(.gray)
        }.frame(width: width, height: 250, alignment: .center)
        .cornerRadius(20)
        .padding()
        .background(Color.staticCVBGC.opacity(0.5))
    }
}

struct StaticCardView_Previews: PreviewProvider {
    static var previews: some View {
        StaticCardView(title: .privacyPolicy, description: .privacyPolicy, width: 300)
    }
}
