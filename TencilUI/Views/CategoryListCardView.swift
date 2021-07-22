//
//  CategoryListCardView.swift
//  TencilUI
//
//  Created by Chandra Mohan on 18/07/21.
//

import SwiftUI
import URLImage
struct CategoryListCardView: View {
    @State var title : String
    @State var width : CGFloat
    @State var bgColor : Color
    @State var imgURL : String
    
    var body: some View {
        VStack(alignment : .center){
            HStack (alignment: .top, spacing: nil, content: {
                Text(title)
                    .font(.system(size: 25,weight: .regular))
                    .foregroundColor(.white)
                    .padding(.bottom,5)
                
                Spacer()
                if let url = URL(string: imgURL){
                    URLImage(url) { image in
                        ZStack{
                            image
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .clipShape(Circle())
                        }
                        

                    }
                
            }
            })

           
                
            Spacer()
        }.frame(width: width, height: 180, alignment: .center)
        .cornerRadius(20)
        .padding()
        .background(bgColor)
        
        
    }
}

struct CategoryListCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListCardView(title: .profile, width: 320, bgColor: Color.buttonBGC, imgURL: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg")
    }
}

