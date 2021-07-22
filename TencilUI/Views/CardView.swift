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
                .font(.system(size: 20))
                .padding(.bottom, 5)
            Text(description)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .lineSpacing(3)
        }.frame(width: width, height: 300, alignment: .center)
        .cornerRadius(20)
        .padding()
        .background(Color.white)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(imageURL: "", title: .privacyPolicy, description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", width: 100)
    }
}
