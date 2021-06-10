//
//  SlideMenuItems.swift
//  TencilUI
//
//  Created by Manu Puthoor on 10/06/21.
//

import SwiftUI

struct SlideMenuItems: View {
    var body: some View {
        ScrollView{
            VStack(alignment : .leading){
               TitleText(title: "Share")
               ItemView(title: "Share", image: "arrowshape.turn.up.forward")
               Divider()
                
                TitleText(title: "Legal")
                ItemView(title: "Privacy Policy", image: "lock.doc")
                Divider()
                
                Group{
                    TitleText(title: "Profile")
                    ItemView(title: "Profile", image: "person")
                    ItemView(title: "Questions", image: "questionmark.circle")
                    ItemView(title: "Log Out", image: "arrow.backward")
                    Divider()
                }
                Group{
                    TitleText(title: "Technical")
                    ItemView(title: "Status Page", image: "gearshape")
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
            .foregroundColor(Color("TitleFC"))
            .font(.system(size: 20, weight: .semibold))
            .padding(.top,16)
    }
}
struct ItemView: View {
    @State var title : String
    @State var image : String
    
    var body: some View {
        HStack{
            Image(systemName: image)
            Text(title)
        }.padding(.top,5)
    }
}
struct SlideMenuItems_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuItems()
    }
}
