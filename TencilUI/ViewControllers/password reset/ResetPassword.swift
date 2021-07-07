//
//  ResetPassword.swift
//  TencilUI
//
//  Created by Chandra Mohan on 04/07/21.
//

import SwiftUI

struct ResetPassword: View {
    @Binding var showResetView : Bool
    @State var email = String()
    @State var newPassword = String()
    @State var code = String()
    @State var isShowingPopUp = false
    @State var isLoading = false
    @State var showCompletion = false
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                ZStack {
                    VStack{
                        Image.lockFill
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50, alignment: .center)
                        Text(String.resetPassword.uppercased())
                            .foregroundColor(.black)
                            .font(.system(size: 35 , weight: .bold))
                            .padding([.horizontal,.top], 20)
                        Text(String.provideEmailAndNewPassword)
                            .foregroundColor(.gray)
                            .frame(width: geometry.size.width / 1.5)
                            .padding()
                        
                        CustomTextField(value: $email, text: .email, image: .mail,keyBoardType: .emailAddress)
                        CustomPasswordField(value: $newPassword, text: .password, image: .lock)
                        CustomPasswordField(value: $code, text: .activationCode, image: .pin)
                        
                        Button(action: {
                            Common().dismissKeyboard()
                            if email.isEmpty || newPassword.isEmpty || code.isEmpty{
                                isShowingPopUp = true
                            }
                            else{
                                isLoading = true
                                Api().resetPassword(email: email, pwd: newPassword, code: code) { status in
                                    isLoading = false
                                    if status == 200{
                                        showCompletion = true
                                    }
                                }
                            }
                        }, label: {
                            CustomButton(width: UIScreen.main.bounds.width * 0.8, title: .resetPassword.uppercased())
                        })
                        .cornerRadius(25)
                        .padding()
                        .padding()
                        Spacer()
                    }
                    .navigationBarItems(leading:
                                            Button(action: {
                                                showResetView = false
                                            }, label: {
                                                Image.back
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 25, height: 25, alignment: .center)
                                                    .foregroundColor(.black)
                                            })
                                        
                )
                }
                if isLoading{
                    LoaderView()
                }
            }
            .fullScreenCover(isPresented: $showCompletion, content: {
                PasswordUpdated(showCompletion: $showCompletion)
            })
            
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
                        Text(String.enterValidEmailID)
                            .foregroundColor(.white)
                    }
                }
                .frame(height: 80, alignment: .center)
                .cornerRadius(10)
                .padding()
                
            }
        }
        
    }
}

struct ResetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ResetPassword(showResetView: Binding.constant(false))
    }
}
