//
//  DetailsView.swift
//  TencilUI
//
//  Created by Manu Puthoor on 27/06/21.
//

import SwiftUI
import AVKit
import URLImage
struct DetailsView: View {
    @State var business : Business
    @Environment(\.openURL) var openURL
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: nil, content: {
                    HStack{
                        if let url = URL(string: business.businessImg){
                            URLImage(url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .foregroundColor(.white)
                                    .font(.system(size: 16,weight: .thin))
                            }
                            .frame(width: 120, height: 120, alignment: .center)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.black, lineWidth: 5))
                        }
                    }
                    .padding([.horizontal,.bottom])
                    Group{
                        Text(business.businessName.uppercased())
                            .font(.system(size: 30 , weight: .regular))
                            .padding([.top], 25)
                        Text(business.bdesc)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 20 , weight: .light))
                            .lineSpacing(5)
                            .padding()
                        Text("RESOURCES")
                            .font(.system(size: 30 , weight: .regular))
                            .padding(.vertical, 25)
                    }
                    HStack{
                        Spacer()
                        Button(action: {
                            openURL(URL(string: business.businessWebsite)!)
                            
                        }, label: {
                            Text("WEBSITE")
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.buttonColor)
                                .foregroundColor(.white)
                                .font(.system(size: 12 , weight: .semibold))
                                .cornerRadius(25)
                            
                            
                        })
                        Spacer()
                        Button(action: {
                            openURL(URL(string: business.businessWebsiteSocial)!)
                        }, label: {
                            Text("SOCIAL MEDIA")
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.buttonColor)
                                .foregroundColor(.white)
                                .font(.system(size: 12 , weight: .semibold))
                                .cornerRadius(25)
                            
                            
                        })
                        Spacer()
                        Button(action: {
                            openURL(URL(string: business.careers)!)
                        }, label: {
                            Text("CAREERS")
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.careerButtonColor)
                                .foregroundColor(.white)
                                .font(.system(size: 12 , weight: .semibold))
                                .cornerRadius(25)
                            
                            
                        })
                        Spacer()
                    }
                    Button(action: {
                        openURL(URL(string: business.contact)!)
                    }, label: {
                        Text("CONTACT")
                            .frame(width: UIScreen.main.bounds.width * 0.7)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.contactButtonColor)
                            .foregroundColor(.white)
                            .font(.system(size: 12 , weight: .semibold))
                            .cornerRadius(25)
                            .padding(.vertical, 25)
                        
                    })
                    Text("VIDEOS")
                        .font(.system(size: 30 , weight: .regular))
                    
                    
                    VStack {
                        VideoPlayer(player: AVPlayer(url: URL(string: business.videos)!))
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width, alignment: .center)
                    }
                    
                    
                    .padding(.vertical)
                    Group{
                        Text("NEWS")
                            .font(.system(size: 30 , weight: .regular))
                        HStack{
                            if let url = URL(string: business.businessImg){
                                URLImage(url) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .foregroundColor(.white)
                                        .font(.system(size: 16,weight: .thin))
                                }
                            }
                            Spacer()
                            Button(action: {
                                openURL(URL(string: business.news)!)
                            }, label: {
                                Text("News Headline")
                                    .foregroundColor(.black)
                                    .font(.system(size: 25 , weight: .regular))
                                    .padding()
                            })
                        }
                        .padding()
                    }
                    Divider()
                    Group{
                        Text("WANT TO BE APART OF TENCIL?")
                            .font(.system(size: 25 , weight: .regular))
                            .padding()
                        Button(action: {
                            openURL(URL(string: business.contact)!)
                        }, label: {
                            Text("CONTACT US")
                                .frame(width: UIScreen.main.bounds.width * 0.8)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.slideMenuC)
                                .foregroundColor(.white)
                                .font(.system(size: 12 , weight: .semibold))
                                .padding(.vertical, 25)
                            
                        })
                    }
                    Spacer()
                })
            }
            
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image.back
                    .renderingMode(.original)
            }))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(business: Business(businessID: "", businessName: "Test", bdesc: "test", catID: "", featured: "", businessImg: "", businessWebsite: "", businessWebsiteSocial: "", careers: "", contact: "", videos: "", news: ""))
    }
}
