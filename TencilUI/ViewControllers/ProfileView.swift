//
//  ProfileView.swift
//  TencilUI
//
//  Created by Chandra Mohan on 18/07/21.
//

import SwiftUI

struct ProfileView: View {
    @State var email : String
    @State var name : String
    @State var password : String
    var body: some View {
        VStack{
            ZStack{
                Color.profileBG
                    .ignoresSafeArea()
                HStack{
                    ScrollView {
                        VStack(alignment : .center){
                            Image(systemName: "person.circle")
                                
                                .resizable()
                                .scaledToFit()
                                .imageScale(.large)
                                .foregroundColor(.blue)
                                .shadow(radius: 10)
                                .frame(width: 100, height: 100, alignment: .center)
                                .padding()
                            Text(email)
                                .foregroundColor(.buttonBGC)
                                .padding([.horizontal])
                                .padding([.top],20)
                            HStack(alignment: .center, spacing: nil, content: {
                                Image.checkMark
                                    .resizable()
                                    .renderingMode(.original)
                                    .frame(width: 12, height: 12, alignment: .center)
                                    .scaledToFit()
                                Text("Verified account")
                                    .font(.system(size: 12,weight: .light))
                                    .foregroundColor(.buttonBGC)
                                
                            })
                            HStack{
                                Button(action: {
                                    Common().dismissKeyboard()
                                }, label: {
                                    Text("Update Details")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .frame(width: 180, height: 30)
                                        .background(Color.buttonBGC)
                                        .cornerRadius(5)
                                        .padding()
                                        
                                })
                                
                                Button(action: {}, label: {
                                    Image(systemName: "chevron.down")
                                        .renderingMode(.template)
                            
                                        .frame(width: 40, height: 30, alignment: .center)
                                })
                                .background(Color.gray)
                                .cornerRadius(5)
                            }
                            Divider()
                            
                            Button(action: {
                                Common().dismissKeyboard()
                            }, label: {
                                Text("Video CV")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .frame(width: 180, height: 30)
                                    .background(Color.buttonBGC)
                                    .cornerRadius(5)
                                    .padding()
                                    
                            })
                            
                          //  ScrollView(.horizontal, showsIndicators: true, content: {
                                HStack(alignment: .center){
                                    Color.blue
                                        .frame(width: 100, height: 130, alignment: .center)
                                        .cornerRadius(8)
                                        .padding(5)
                                    Color.red
                                        .frame(width: 100, height: 130, alignment: .center)
                                        .cornerRadius(8)
                                        .padding(5)
                                    Color.blue
                                        .frame(width: 100, height: 130, alignment: .center)
                                        .cornerRadius(8)
                                        .padding(5)
                                }
                           // })
                            
                            
                            Button(action: {
                                Common().dismissKeyboard()
                            }, label: {
                                Text("Upload New Video")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .frame(width: 180, height: 30)
                                    .background(Color.red)
                                    .cornerRadius(5)
                                    .padding()
                                    
                            })
                        }
                        .foregroundColor(.white)
                    }
                    
                }
            }
            Spacer()
        }
        .navigationTitle(Text(name.uppercased()))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(email: "steve@yopmail.com", name: "steve", password: "123456")
    }
}
