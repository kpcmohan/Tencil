//
//  RegisterView.swift
//  TencilUI
//
//  Created by  on 10/06/21.
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
                    Text(String.register)
                        .foregroundColor(.gray)
                        .font(.system(size: 50 , weight: .bold))
                        .padding([.horizontal,.top], 20)
                    Spacer()
                }
                
                HStack {
                    Text(String.registerAndControl)
                        .foregroundColor(.gray)
                        .font(.system(size: 25 , weight: .regular))
                        .padding([.horizontal], 20)
                    Spacer()
                }
                .padding(.bottom, 50)
                CustomTextField(value: $email, text: .email, image: .mail)
                CustomTextField(value: $name, text: .name, image: .person)
                CustomPasswordField(value: $password, text: .password, image: .lock)
                CustomPasswordField(value: $rePassword, text: .rePassword, image: .lock)
                
                
                Button(action: {
                    registerView.toggle()
                }, label: {
                    CustomButton(width: geometry.size.width - 30, title: .register.uppercased())
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
