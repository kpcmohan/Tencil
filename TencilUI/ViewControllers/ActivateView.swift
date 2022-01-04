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
    //Title Text
                    HStack {
                        Text(String.activate)
                            .foregroundColor(.gray)
                            .font(.system(size: geometry.size.width / 10 , weight: .bold))
                            .padding([.horizontal,.top], 20)
                        Spacer()
                    }
                    HStack {
                        Text(String.account)
                            .foregroundColor(.gray)
                            .font(.system(size: geometry.size.width / 10 , weight: .bold))
                            .padding([.horizontal], 20)
                        Spacer()
                    }
    //Sub Title
                    HStack {
                        Text(String.enterActivationCode)
                            .foregroundColor(.gray)
                            .font(.system(size: geometry.size.width / 16 , weight: .regular))
                            .padding([.horizontal], 20)
                        Spacer()
                    }
                    .padding(.bottom, 50)
    //Text Fields
                    CustomTextField(value: $email, text: .email, image: .mail)
                    CustomPasswordField(value: $activationCode, text: .activationCode, image: .lockShield )
    //Activate Button
                    Button(action: {
                        isLoading = true
                        Api().activate(email: email, code: activationCode) { statusCode in
                            isLoading = false
                            if statusCode != 200{
                                isShowingPopUp = true
                            }else{
                                isShowingPopUp = false
                                activateView = false
                                showQA = true
                            }
                        }
                        
                    }, label: {
                        CustomButton(width: geometry.size.width *  0.9, height: geometry.size.width / 7, title: .activate)
                    })
                    .padding(.top , 50)
                    Spacer()
    //Resend Code Button
                    Button(action: {}, label: {
                        CustomButton(width: geometry.size.width / 2, height: geometry.size.width / 7, title: .resendCode)
                            .cornerRadius(50)
                    })
                }
                .navigationBarItems(leading:
                                        Button(action: {
                                            activateView = false
                                        }, label: {
                                            HStack {
                                                Image.back
                                                    .resizable()
                                                    .scaledToFit()
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(.black)
                                            }
                                            .frame(width: 45, height: 45)
                                        })
                                    
            )
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
        ActivateView(activateView: .constant(false))
    }
}
