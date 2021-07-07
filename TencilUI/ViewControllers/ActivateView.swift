//
//  ActivateView.swift
//  TencilUI
//
//  Created by  on 10/06/21.
//

import SwiftUI
import PopupView
struct ActivateView: View {
    @State var email = String()
    @State var activationCode = String()
    @State var isShowingPopUp = false
    @State var isLoading = false
    @Binding var activateView : Bool
    @State var showQA = false
    var body: some View {
        ZStack{
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text(String.activate)
                        .foregroundColor(.gray)
                        .font(.system(size: 50 , weight: .bold))
                        .padding([.horizontal,.top], 20)
                    Spacer()
                }
                HStack {
                    Text(String.account)
                        .foregroundColor(.gray)
                        .font(.system(size: 50 , weight: .bold))
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
                    isLoading = true
                    Api().activate(email: email, code: activationCode) { statusCode in
                        isLoading = false
                        if statusCode != 200{
                            isShowingPopUp = true
                        }else{
                            isShowingPopUp = false
                            showQA = true
                        }
                    }
                    
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
            .fullScreenCover(isPresented: $showQA, content: {
                Questionnaire(fromHome: Binding.constant(false))
            })
        }
            if isLoading{
            LoaderView()
            }
    }
        .popup(isPresented: $isShowingPopUp, type: .floater(verticalPadding: 20), position: .top, animation: .easeIn, autohideIn: 3, dragToDismiss: true, closeOnTap: true, closeOnTapOutside: false) {
            isShowingPopUp = false
        } view: {
            ZStack{
                Color.primary
                HStack{
                    Image.warning
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(.white)
                    Text(String.somthingWentWrong)
                        .foregroundColor(.white)
                }
            }
            .frame(height: 80, alignment: .center)
            .cornerRadius(10)
            .padding()
            
        }
    }
    
}

struct ActivateView_Previews: PreviewProvider {
    static var previews: some View {
        ActivateView(activateView: .constant(true))
    }
}
