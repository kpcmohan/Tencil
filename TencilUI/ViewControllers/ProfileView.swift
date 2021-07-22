//
//  ProfileView.swift
//  TencilUI
//
//  Created by Chandra Mohan on 18/07/21.
//

import SwiftUI

struct ProfileView: View {
    @State var email : String
    @State var name : String
    @State var password : String
    var body: some View {
        VStack{
            ZStack{
                Color.buttonBGC
                    .ignoresSafeArea()
                HStack{
                    VStack(alignment : .leading){
                        Text(name.uppercased())
                            .font(.system(size: 25,weight: .bold))
                            .padding([.horizontal])
                        Text(email)
                            .padding([.horizontal])
                    }
                    .foregroundColor(.white)
                    Spacer()
                }
                
                    ZStack{
                        Color.buttonBGC
                            
                        Button(action: {}, label: {
                            Text("Want to Edit your details?")
                                .font(.system(size: 25,weight: .regular))
                                .padding([.horizontal])
                                .foregroundColor(.white)
                        })
                    }
                    .offset(y: (UIScreen.main.bounds.width * 0.7) / 2)
                    .frame(width : UIScreen.main.bounds.width * 0.8,height: 100, alignment: .center)
                
            }
            .frame(height: UIScreen.main.bounds.width * 0.7, alignment: .center)
            Spacer()
            VStack{
                CustomTextField(value: $email, text: .email, image: .mail)
                CustomTextField(value: $name, text: .name, image: .person)
                CustomPasswordField(value: $password, text: .password, image: .lock)
                
                Button(action: {
                    Common().dismissKeyboard()
                    
                    //homeView.toggle()
                }, label: {
                    CustomButton(width: UIScreen.main.bounds.width - 30, title: "UPDATE DETAILS")
                })
                .padding(.bottom)
            }
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(email: "steve@yopmail.com", name: "steve", password: "123456")
    }
}
