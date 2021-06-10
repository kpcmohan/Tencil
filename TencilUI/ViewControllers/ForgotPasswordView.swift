//
//  ForgotPasswordView.swift
//  TencilUI
//
//  Created by Manu Puthoor on 10/06/21.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var email = String()
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                VStack{
                    Image(systemName: "lock.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50, alignment: .center)
                    Text("FORGOT PASSWORD?")
                    Text("Provide Your Account Email To Reset Your Password")
                        .foregroundColor(.gray)
                        .frame(width: geometry.size.width / 2)
                        .padding()
                    
                    HStack{
                        Image(systemName: "mail")
                        TextField("Email", text: $email)
                    }
                    .padding()
                    Button(action: {
                      
                    }, label: {
                        CustomButton(width: geometry.size.width, title: "Login")
                    })
                    .padding()
                    Spacer()
                }
                .navigationBarItems(leading:
                                        Button(action: {}, label: {
                                            Image(systemName: "chevron.left")
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
