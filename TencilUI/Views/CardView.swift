//
//  CardView.swift
//  TencilUI
//
//  Created by  on 10/06/21.
//

import SwiftUI
import URLImage
struct CardView: View {
    @State var imageURL : String
    @State var title : String
    @State var description : String
    @State var width : CGFloat
    var body: some View {
        VStack(alignment : .center){
            if let url = URL(string: imageURL){
                URLImage(url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 125, height: 125, alignment: .center)
                        .foregroundColor(.white)
                        .font(.system(size: 16,weight: .thin))
                }
            }
            Text(title)
                .font(.system(size: 30))
            Text(description)
        }.frame(width: width, height: 250, alignment: .center)
        .cornerRadius(20)
        .padding()
        .background(Color.white)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(imageURL: "", title: .privacyPolicy, description: .privacyPolicy, width: 100)
    }
}
