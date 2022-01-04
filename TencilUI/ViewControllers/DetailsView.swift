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
    var titleSize = CGFloat(25)
    var contentSize = CGFloat(15)
    @State var business : Business
    @Environment(\.openURL) var openURL
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .center, spacing: nil, content: {
    // Logo
                        HStack{
                            if let url = URL(string: business.businessImg){
                                URLImage(url) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width / 4, height: geometry.size.width / 4, alignment: .center)
                                        .foregroundColor(.white)
                                }
                                .frame(width: geometry.size.width / 4, height: geometry.size.width / 4, alignment: .center)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.blue, lineWidth: 3))
                            }
                        }
                        .padding([.horizontal,.bottom])
                        Group{
    // Business Name
                            Text(business.businessName)
                                .font(.callout.bold())
                                .scaledToFill()
                                .minimumScaleFactor(1)
                                .frame(height: 60)
                                .padding(.top)
    //Verified Text
                            HStack(alignment: .center, spacing: nil, content: {
                                Image.checkMark
                                    .resizable()
                                    .renderingMode(.original)
                                    .frame(width: 12, height: 12, alignment: .center)
                                    .scaledToFit()
                                Text("Verified Business")
                                    .font(.system(size: 12,weight: .light))
                                    .foregroundColor(.buttonBGC)
                                
                            })
                                .padding(.bottom)
    //Description Title
                            Text("Business Description")
                                .font(.callout.bold())
                                .padding(.bottom)
    //Business DEscription
                            Text(business.bdesc)
                                .multilineTextAlignment(.center)
                                .font(.footnote)
                                .lineSpacing(2)
                                .padding([.horizontal,.bottom])
                            Divider()
    //Resources Text
                            Text("Resources")
                                .font(.callout.bold())
                                .padding(.vertical, 10)
                        }
                        HStack{
                            Spacer()
    //Button Website
                            Button(action: {
                                openURL(URL(string: business.businessWebsite)!)
                                
                            }, label: {
                                Text("Website")
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .foregroundColor(.buttonBGC)
                                    .font(.system(size: 12 , weight: .semibold))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.buttonBGC, lineWidth: 2)
                                    )
                                
                            })
                            Spacer()
    //Button Social Media
                            Button(action: {
                                openURL(URL(string: business.businessWebsiteSocial)!)
                            }, label: {
                                Text("Social Media")
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .foregroundColor(.buttonBGC)
                                    .font(.system(size: 12 , weight: .semibold))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.buttonBGC, lineWidth: 2)
                                    )
                                
                                
                            })
                            Spacer()
    //Button Careers
                            Button(action: {
                                openURL(URL(string: business.careers)!)
                            }, label: {
                                Text("Careers")
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .foregroundColor(.buttonBGC)
                                    .font(.system(size: 12 , weight: .semibold))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.buttonBGC, lineWidth: 2)
                                    )
                                
                                
                            })
                            Spacer()
                        }
    //Button Contact
                        Button(action: {
                            openURL(URL(string: business.contact)!)
                        }, label: {
                            Text("Contact")
                                .frame(width: UIScreen.main.bounds.width * 0.7)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .foregroundColor(.buttonBGC)
                                .font(.system(size: 12 , weight: .semibold))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.buttonBGC, lineWidth: 2)
                                )
                                .padding(.vertical, 25)
                            
                        })
    //Text Video
                        Text("Videos")
                            .font(.callout.bold())
                        
    //Video Player
                        VStack {
                            VideoPlayer(player: AVPlayer(url: URL(string: business.videos)!))
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width, alignment: .center)
                        }
                        
                        
                        .padding(.vertical)
                        Group{
                            Divider()
                            Text("News")
                                .font(.callout.bold())
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
                                        .font(.callout.bold())
                                        .padding()
                                })
                            }
                            .padding()
                        }
                        Divider()
                        Group{
                            Text("Want to be a part of Tencil?")
                                .font(.callout.bold())
                                .padding()
                            Button(action: {
                                openURL(URL(string: business.contact)!)
                            }, label: {
                                Text("Contact us")
                                    .frame(width: UIScreen.main.bounds.width * 0.8)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .foregroundColor(.buttonBGC)
                                    .font(.system(size: 12 , weight: .semibold))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.buttonBGC, lineWidth: 2)
                                    )
                                    .padding(.vertical, 25)
                                
                            })
                        }
                        Spacer()
                    })
                }
                
                .navigationBarItems(leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Image.back
                            .resizable()
                            .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.black)
                    }
                    .frame(width: 45, height: 45)
            }))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(business: Business(businessID: "1", businessName: "Microsoft", bdesc: "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.", catID: "1", featured: "1", businessImg: "https://images.fastcompany.net/image/upload/w_1280,f_auto,q_auto,fl_lossy/w_596,c_limit,q_auto:best,f_auto/fc/3034007-inline-i-applelogo.jpg", businessWebsite: "", businessWebsiteSocial: "", careers: "", contact: "", videos: "https://www.youtube.com/watch?v=TQGkZ5oGmuw", news: ""))
    }
}
