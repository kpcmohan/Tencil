//
//  RegisterView.swift
//  TencilUI
//
//  Created by  on 10/06/21.
//

import SwiftUI
import PopupView
struct RegisterView: View {
    
    @State var email = String()
    @State var name = String()
    @State var password = String()
    @State var rePassword = String()
    @State var isShowingPopUp = false
    @State var isLoading = false
    @State var showVerificationSentMessage = false
    @Binding var registerView : Bool
    var body: some View {
        ZStack{
                GeometryReader { geometry in
                        VStack {
    //Register Text
                        HStack {
                            Text(String.register)
                                .foregroundColor(.gray)
                                .font(.system(size: geometry.size.width / 10 , weight: .bold))
                                .padding([.horizontal,.top], 20)
                            Spacer()
                        }
    //Sub Text
                        HStack {
                            Text(String.registerAndControl)
                                .foregroundColor(.gray)
                                .font(.system(size: geometry.size.width / 16 , weight: .regular))
                                .padding([.horizontal], 20)
                            Spacer()
                        }
                        .padding(.bottom, 50)
    //Text Fields
                        CustomTextField(value: $email, text: .email, image: .mail)
                        CustomTextField(value: $name, text: .name, image: .person)
                        CustomPasswordField(value: $password, text: .password, image: .lock)
                        CustomPasswordField(value: $rePassword, text: .rePassword, image: .lock)
    //Register Button
                        Button(action: {
                            isLoading = true
                            Api().register(email: email, password: password, fullName: name) { statusCode in
                                isLoading = false
                                if statusCode != 201{
                                    isShowingPopUp = true
                                }else{
                                    isShowingPopUp = false
                                }
                                showVerificationSentMessage = !isShowingPopUp
                                
                            }
                        }, label: {
                            CustomButton(width: geometry.size.width * 0.8, height: geometry.size.width / 7, title: .register)
                        })
                        .padding(.top , 50)
                        Spacer()
                        
                        }
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
        .popup(isPresented: $showVerificationSentMessage, type: .floater(verticalPadding: 20), position: .top, animation: .easeIn, autohideIn: 3, dragToDismiss: true, closeOnTap: true, closeOnTapOutside: false) {
            showVerificationSentMessage = false
            registerView.toggle()
        } view: {
            ZStack{
                Color.primary
                HStack{
                    Image.mail
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor(.white)
                    Text(String.verificationCodeSent)
                        .foregroundColor(.white)
                }
            }
            .frame(height: 80, alignment: .center)
            .cornerRadius(10)
            .padding()
            
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView( registerView: .constant(true))
    }
}
