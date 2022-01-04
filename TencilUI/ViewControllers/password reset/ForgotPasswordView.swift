//
//  ForgotPasswordView.swift
//  TencilUI
//
//  Created by  on 10/06/21.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Binding var forgotPasswordView : Bool
    @State var email = String()
    @State var isShowingPopUp = false
    @State var showResetView = false
    @State var isLoading = false
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                ZStack {
                    VStack{
                        Image.lockFill
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width / 4, height: geometry.size.width / 4, alignment: .center)
                            .padding()
                        Text(String.forgotPassword.uppercased())
                            .foregroundColor(.black)
                            .font(.system(size: geometry.size.width / 15 , weight: .bold))
                            .padding([.horizontal,.top], 20)
                        Text(String.provideEmail)
                            .foregroundColor(.gray)
                            .frame(width: geometry.size.width / 2)
                            .padding()
                        
                        CustomTextField(value: $email, text: .email, image: .mail,keyBoardType: .emailAddress)
                        
                        Button(action: {
                            Common().dismissKeyboard()
                            if email.isEmpty{
                                isShowingPopUp = true
                            }
                            else{
                                isLoading = true
                                Api().sendEmail(email: email) { status in
                                    isLoading = false
                                    if status == 200{
                                        showResetView = true
                                    }
                                    else{
                                        
                                    }
                                }
                            }
                        }, label: {
                            CustomButton(width: UIScreen.main.bounds.width * 0.8, height: geometry.size.width / 3, title: .next.uppercased())
                        })
                            .cornerRadius(25)
                            .padding()
                            .padding()
                        
                        
                        Spacer()
                    }
                    .navigationBarItems(leading:
                                            Button(action: {
                        forgotPasswordView = false
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
                }
                if isLoading{
                    LoaderView()
                }
            }
            .fullScreenCover(isPresented: $showResetView, content: {
                ResetPassword(showResetView: $showResetView)
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView(forgotPasswordView: Binding.constant(true))
    }
}
