//
//  SlideMenuItems.swift
//  TencilUI
//
//  Created by  on 10/06/21.
//

import SwiftUI

struct SlideMenuItems: View {
    var body: some View {
        ScrollView{
            VStack(alignment : .leading){
                TitleText(title: .share)
                ItemView(title: .share, image: .share)
               Divider()
                
                TitleText(title: .leagal)
                ItemView(title: .privacyPolicy, image: .privacyPolicy)
                Divider()
                
                Group{
                    TitleText(title: .profile)
                    ItemView(title: .profile, image: .person)
                    ItemView(title: .questions, image: .question)
                    ItemView(title: .logOut, image: .logOut)
                    Divider()
                }
                Group{
                    TitleText(title: .technical)
                    ItemView(title: .statusPage, image: .gear)
                    Divider()
                }
            }
            .padding()
        }
    }
}

struct TitleText: View {
    @State var title : String
    var body: some View {
        Text(title)
            .foregroundColor(Color.titleFC)
            .font(.system(size: 20, weight: .semibold))
            .padding(.top,16)
    }
}
struct ItemView: View {
    @State var title : String
    @State var image : Image
    
    var body: some View {
        HStack{
            image
            Text(title)
        }.padding(.top,5)
    }
}
struct SlideMenuItems_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuItems()
    }
}
