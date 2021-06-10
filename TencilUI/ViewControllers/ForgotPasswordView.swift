//
//  ForgotPasswordView.swift
//  TencilUI
//
//  Created by  on 10/06/21.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var email = String()
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                VStack{
                    Image.lockFill
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50, alignment: .center)
                    Text(String.forgotPassword.uppercased())
                    Text(String.provideEmail)
                        .foregroundColor(.gray)
                        .frame(width: geometry.size.width / 2)
                        .padding()
                    
                    HStack{
                        Image.mail
                        TextField(String.email, text: $email)
                    }
                    .padding()
                    Button(action: {
                      
                    }, label: {
                        CustomButton(width: geometry.size.width, title: .login)
                    })
                    .padding()
                    Spacer()
                }
                .navigationBarItems(leading:
                                        Button(action: {}, label: {
                                            Image.back
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 25, height: 25, alignment: .center)
                                                .foregroundColor(.black)
                                        })
                                    
            )
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
