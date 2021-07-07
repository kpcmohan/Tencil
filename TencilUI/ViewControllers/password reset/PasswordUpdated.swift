//
//  PasswordUpdated.swift
//  TencilUI
//
//  Created by Chandra Mohan on 04/07/21.
//

import SwiftUI

struct PasswordUpdated: View {
    @Binding var showCompletion : Bool
    @State var showLogin = false
    var body: some View {
        VStack {
            Spacer()
            Text(String.passwordUpdated.uppercased())
                .foregroundColor(.black)
                .font(.system(size: 35 , weight: .bold))
                .padding([.horizontal,.top], 20)
            Image.checkMark
                .resizable()
                .frame(width: 125, height: 125, alignment: .center)
                .scaledToFit()
            Text(String.passwordUpdatedSuccessfully)
                .foregroundColor(.black)
                .font(.system(size: 25 , weight: .regular))
                .padding([.horizontal,.top], 20)
            Button(action: {
                showLogin = true
            }, label: {
                CustomButton(width: UIScreen.main.bounds.width * 0.8, title: .login.uppercased())
            })
            .cornerRadius(25)
            .padding()
            .padding()
           
            Spacer()
        }
        .fullScreenCover(isPresented: $showLogin, content: {
            LoginView()
        })
    }
}

struct PasswordUpdated_Previews: PreviewProvider {
    static var previews: some View {
        PasswordUpdated(showCompletion: Binding.constant(false))
    }
}
