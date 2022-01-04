//
//  LoginView.swift
//  TencilUI
//
//  Created by  on 10/06/21.
//

import SwiftUI
import PopupView

struct LoginView : View {
    @State var email = String()
    @State var password = String()
    @State var homeView = Bool()
    @State var registerView = Bool()
    @State var activateView = Bool()
    @State var forgotPasswordView = Bool()
    @State var isShowingPopUp = false
    @State var isLoading = false
    @AppStorage("uid") var uid : String?
    @AppStorage("fname") var fname : String?
    @AppStorage("userAPIKey") var userAPIKey : String?
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack{
                    Spacer()
    //App Logo
                    Image.logo
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width / 3, height: geometry.size.width / 3)
                        .padding()
    // Text Fields
                    CustomTextField(value: $email, text: .email, image: .person,keyBoardType: .emailAddress)
                    CustomPasswordField(value: $password, text: .password, image: .lock)
                        .fullScreenCover(isPresented: $homeView, content: {
                            HomeView()
                        })
                        .fullScreenCover(isPresented: $registerView, content: {
                            RegisterView(registerView: $registerView)
                        })
                        .fullScreenCover(isPresented: $activateView, content: {
                            ActivateView(activateView: $activateView)
                        })
                        .fullScreenCover(isPresented: $forgotPasswordView, content: {
                            ForgotPasswordView(forgotPasswordView: $forgotPasswordView)
                        })
                    HStack {
                        Spacer()
    //Login Button
                        Button(action: {
                            Common().dismissKeyboard()
                            isLoading = true
                            Api().login(email: email, password: password) { loginResponse in
                                isLoading = false
                                if loginResponse.userActive{
                                    uid = loginResponse.uid
                                    fname = loginResponse.fname
                                    userAPIKey = loginResponse.userAPIKey
                                    isShowingPopUp = false
                                    homeView = true
                                }
                                else{
                                    isShowingPopUp = true
                                }
                            }
                        }, label: {
                            CustomButton(width: geometry.size.width * 0.9, height: geometry.size.width / 7, title: .login)
                        })
                            .padding(.bottom)
                        Spacer()
                    }
                    Button(action: {
                        forgotPasswordView = true
                    }, label: {
                        Text(String.forgotPassword)
                            .font(.title3)
                            .foregroundColor(.gray)
                    })
                    Spacer()
                    HStack{
    //Register Button
                        Button(action: {
                            registerView = true
                        }, label: {
                            CustomButton(width: geometry.size.width / 3, height: geometry.size.width / 7, title: .register)
                        })
                        .padding()
    //Activate Button
                        Button(action: {
                            activateView = true
                        }, label: {
                            CustomButton(width: geometry.size.width / 3, height: geometry.size.width / 7, title: .activate)
                        })
                        .padding()
                    }
                    
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
                    Text(String.loginError)
                        .foregroundColor(.white)
                }
            }
            .frame(height: 80, alignment: .center)
            .cornerRadius(10)
            .padding()
            
        }
        
    }
}

struct CustomTextField : View {
    @Binding var value : String
    @State var text : String
    @State var image : Image
    @State var keyBoardType = UIKeyboardType.default
    var body : some View{
        HStack {
            TextField(text, text: $value)
                .keyboardType(keyBoardType)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            image
        }.padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color.black)
        )
        .padding([.horizontal])
        .padding(.vertical, 5)
    }
    
}
struct CustomPasswordField : View {
    @Binding var value : String
    @State var text : String
    @State var image : Image
    var body : some View{
        HStack {
            SecureField(text, text: $value)
            image
        }.padding()
        // .background()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color.black)
        )
        
        .padding([.horizontal,.bottom])
        
    }
    
}
struct CustomButton : View {
    @State var width : CGFloat
    @State var height : CGFloat
    
    @State var title : String
    var body : some View{
                VStack(alignment: .center) {
                    Text(title)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: width, height: height)
                    .background(Color.buttonBGC)
            }
        }
    }
    

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(email: "", password: "", homeView: false, registerView: false, activateView: false, forgotPasswordView: false, isShowingPopUp: false, isLoading: false)
        
    }
}
