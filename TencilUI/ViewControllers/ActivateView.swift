//
//  ActivateView.swift
//  TencilUI
//
//  Created by  on 10/06/21.
//

import SwiftUI

struct ActivateView: View {
    @State var email = String()
    @State var activationCode = String()
    
    @Binding var activateView : Bool
    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text(String.activate)
                        .foregroundColor(.gray)
                        .font(.system(size: 60 , weight: .bold))
                        .padding([.horizontal,.top], 20)
                    Spacer()
                }
                HStack {
                    Text(String.account)
                        .foregroundColor(.gray)
                        .font(.system(size: 60 , weight: .bold))
                        .padding([.horizontal], 20)
                    Spacer()
                }
                
                HStack {
                    Text(String.enterActivationCode)
                        .foregroundColor(.gray)
                        .font(.system(size: 25 , weight: .regular))
                        .padding([.horizontal], 20)
                    Spacer()
                }
                .padding(.bottom, 50)
                CustomTextField(value: $email, text: .email, image: .mail)
                CustomPasswordField(value: $activationCode, text: .activationCode, image: .lockShield )
                
                
                Button(action: {
                    activateView.toggle()
                }, label: {
                    CustomButton(width: geometry.size.width - 30, title: .activate.uppercased())
                })
                .padding(.top , 50)
                Spacer()
                
                Button(action: {}, label: {
                    CustomButton(width: geometry.size.width / 2, title: .resendCode)
                        .cornerRadius(50)
                })
            }
        }
    }
}

struct ActivateView_Previews: PreviewProvider {
    static var previews: some View {
        ActivateView(activateView: .constant(true))
    }
}
