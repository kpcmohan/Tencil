//
//  SlideMenuItems.swift
//  TencilUI
//
//  Created by  on 10/06/21.
//

import SwiftUI

struct SlideMenuItems: View {
    @Binding var isShowing : Bool
    @State var isLogin = false
    @State var isShare = false
    @Environment(\.openURL) var openURL
    var body: some View {
        ScrollView{
            VStack(alignment : .leading){
                
                   
              
                ItemView(title: .home, image: .home)
                    .onTapGesture {
                        withAnimation (.spring()){
                            isShowing.toggle()
                        }
                    }
              
                Divider()
                
                Group{
                    TitleText(title: .profile)
                    NavigationLink(
                        destination: ProfileView(email: "steve@yopmail.com", name: "steve", password: "123456"),
                        label: {
                            ItemView(title: .profile, image: .person)
                        })
                        .foregroundColor(.black)
                    
                    NavigationLink(
                        destination: Questionnaire(fromHome: Binding.constant(true)),
                        label: {
                            ItemView(title: .questions, image: .question)
                        })
                        .foregroundColor(.black)
                    
                    ItemView(title: .logOut, image: .logOut)
                        .onTapGesture {
                            isLogin = true
                        }
                        .fullScreenCover(isPresented: $isLogin, content: {
                            LoginView()
                        })
                    Divider()
                }
                
                TitleText(title: .share)
                ItemView(title: .share, image: .share)
                    .onTapGesture {
                        isShare = true
                    }
                    .sheet(isPresented: $isShare, onDismiss: {
                               print("Dismiss")
                           }, content: {
                               ActivityViewController(activityItems: [URL(string: "https://www.apple.com")!])
                           })
               Divider()
                
                TitleText(title: .leagal)
                ItemView(title: .privacyPolicy, image: .privacyPolicy)
                    .onTapGesture {
                        openURL(URL(string: "https://www.tencil.co.uk/appwaitinglist")!)
                    }
                Divider()
                
                
                Group{
                    TitleText(title: .technical)
                    ItemView(title: .statusPage, image: .gear)
                        .onTapGesture {
                            openURL(URL(string: "https://www.tencil.co.uk")!)
                        }
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
            .font(.system(size: 15, weight: .semibold))
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
        }.padding(.top,15)
    }
}
struct SlideMenuItems_Previews: PreviewProvider {
    static var previews: some View {
        SlideMenuItems(isShowing: Binding.constant(true))
    }
}
