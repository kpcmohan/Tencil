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
                    .font(.system(size: 30 , weight: .bold))
                    .minimumScaleFactor(0.5)
                    .padding([.horizontal,.top], 20)
                    .lineLimit(1)
                Image.checkMark
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .scaledToFit()
                Text(String.passwordUpdatedSuccessfully)
                    .foregroundColor(.black)
                    .font(.system(size: 25 , weight: .regular))
                    .padding([.horizontal,.top], 20)
                Button(action: {
                    showLogin = true
                }, label: {
                    CustomButton(width: UIScreen.main.bounds.width * 0.8, height: 60, title: .login.uppercased())
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
