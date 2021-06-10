//
//  LoginView.swift
//  TencilUI
//
//  Created by Manu Puthoor on 10/06/21.
//

import SwiftUI

struct LoginView: View {
    @State var email = String()
    @State var password = String()
    @State var homeView = Bool()
    @State var registerView = Bool()
    @State var activateView = Bool()
    @State var forgotPasswordView = Bool()
    
    var body: some View {
            GeometryReader { geometry in
                VStack{
                    Spacer()
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                        .padding()
                    CustomTextField(value: $email, text: "Email", imageName: "person")
                    CustomPasswordField(value: $password, text: "Password", imageName: "lock")
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
                            ForgotPasswordView()
                        })
                    Button(action: {
                        homeView.toggle()
                    }, label: {
                        CustomButton(width: geometry.size.width - 30, title: "Login")
                    })
                        .padding(.bottom)
                    Button(action: {
                        forgotPasswordView.toggle()
                    }, label: {
                        Text("Forgot Password?")
                            .font(.title3)
                            .foregroundColor(.gray)
                    })
                    Spacer()
                    HStack{
                        Button(action: {
                            registerView.toggle()
                        }, label: {
                            CustomButton(width: 150, title: "REGISTER")
                        })
                        .padding()
                        Button(action: {
                            activateView.toggle()
                        }, label: {
                            CustomButton(width: 150, title: "ACTIVATE")
                        })
                        .padding()
                    }
                    
                }
            }
    }
}

struct CustomTextField : View {
    @Binding var value : String
    @State var text : String
    @State var imageName : String
    var body : some View{
        HStack {
            TextField(text, text: $value)
            Image(systemName: imageName)
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
    @State var imageName : String
    var body : some View{
        HStack {
            SecureField(text, text: $value)
            Image(systemName: imageName)
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
    @State var title : String
    var body : some View{
        
            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .frame(width: width, height: 50)
                .background(Color("ButtonBG"))
    }
    
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            
    }
}
