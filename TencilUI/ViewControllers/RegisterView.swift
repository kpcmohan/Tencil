//
//  RegisterView.swift
//  TencilUI
//
//  Created by Manu Puthoor on 10/06/21.
//

import SwiftUI

struct RegisterView: View {
    
    @State var email = String()
    @State var name = String()
    @State var password = String()
    @State var rePassword = String()
    
    @Binding var registerView : Bool
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text("Register")
                        .foregroundColor(.gray)
                        .font(.system(size: 60 , weight: .bold))
                        .padding([.horizontal,.top], 20)
                    Spacer()
                }
                
                HStack {
                    Text("Register & Control Your Future Today!")
                        .foregroundColor(.gray)
                        .font(.system(size: 25 , weight: .regular))
                        .padding([.horizontal], 20)
                    Spacer()
                }
                .padding(.bottom, 50)
                CustomTextField(value: $email, text: "Email", imageName: "mail")
                CustomTextField(value: $name, text: "Name", imageName: "person")
                CustomPasswordField(value: $password, text: "Password", imageName: "lock")
                CustomPasswordField(value: $rePassword, text: "Re-type Password", imageName: "lock")
                
                
                Button(action: {
                    registerView.toggle()
                }, label: {
                    CustomButton(width: geometry.size.width - 30, title: "REGISTER")
                })
                .padding(.top , 50)
                Spacer()
                
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView( registerView: .constant(true))
    }
}
