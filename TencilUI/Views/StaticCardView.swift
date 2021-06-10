//
//  StaticCardView.swift
//  TencilUI
//
//  Created by Manu Puthoor on 10/06/21.
//

import SwiftUI

struct StaticCardView: View {
    @State var title : String
    @State var description : String
    var body: some View {
        VStack(alignment : .center){
            Text(title)
                .font(.system(size: 25))
                .padding(.bottom,5)
            Text(description)
                .foregroundColor(.gray)
        }.frame(width: 150, height: 250, alignment: .center)
        .cornerRadius(20)
        .padding()
        .background(Color("StaticHCVBG").opacity(0.5))
    }
}

struct StaticCardView_Previews: PreviewProvider {
    static var previews: some View {
        StaticCardView(title: "Test", description: "Testing ")
    }
}
