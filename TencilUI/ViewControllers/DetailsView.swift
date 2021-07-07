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
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: nil, content: {
                Text(business.businessName.uppercased())
                    .font(.system(size: 40 , weight: .regular))
                Text(business.bdesc)
                    .font(.system(size: 20 , weight: .light))
                    .lineSpacing(5)
                    .padding()
                Text("RESOURCES")
                    .font(.system(size: 40 , weight: .regular))
                    .padding(.vertical, 25)
                HStack{
                    Button(action: {}, label: {
                        Text("WEBSITE")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.buttonColor)
                            .foregroundColor(.white)
                            .font(.system(size: 17 , weight: .semibold))
                            .cornerRadius(25)
                        
                        
                    })
                    Button(action: {}, label: {
                        Text("SOCIAL MEDIA")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.buttonColor)
                            .foregroundColor(.white)
                            .font(.system(size: 17 , weight: .semibold))
                            .cornerRadius(25)
                        
                        
                    })
                    Button(action: {}, label: {
                        Text("CAREERS")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.buttonColor)
                            .foregroundColor(.white)
                            .font(.system(size: 17 , weight: .semibold))
                            .cornerRadius(25)
                        
                        
                    })
                }
                Button(action: {}, label: {
                    Text("CONTACT")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .font(.system(size: 17 , weight: .semibold))
                        .cornerRadius(25)
                        .padding(.vertical, 25)
                    
                })
                Text("VIDEOS")
                    .font(.system(size: 40 , weight: .regular))
        
                    
                    VStack {
                        VideoPlayer(player: AVPlayer(url: URL(string: business.videos)!))
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width, alignment: .center)
                    }
                        
                
                .padding(.vertical)
                Text("NEWS")
                    .font(.system(size: 40 , weight: .regular))
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
                    Text("News Headline")
                        .font(.system(size: 30 , weight: .regular))
                        .padding()
                }
                .padding()
                Spacer()
            })
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(business: Business(businessID: "", businessName: "Test", bdesc: "test", catID: "", featured: "", businessImg: "", businessWebsite: "", businessWebsiteSocial: "", careers: "", contact: "", videos: "", news: ""))
    }
}
