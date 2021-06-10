//
//  CardView.swift
//  TencilUI
//
//  Created by Manu Puthoor on 10/06/21.
//

import SwiftUI

struct CardView: View {
    @State var image : String
    @State var title : String
    @State var description : String
    var body: some View {
        VStack(alignment : .center){
            Image(systemName: image)
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .aspectRatio(contentMode: .fit)
            Text(title)
                .font(.system(size: 30))
            Text(description)
        }.frame(width: 150, height: 250, alignment: .center)
        .cornerRadius(20)
        .padding()
        .background(Color.white)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(image: "person", title: "Provide", description: "Description")
    }
}
