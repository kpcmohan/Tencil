//
//  PlayerView.swift
//  TencilUI
//
//  Created by Chandra Mohan on 22/09/21.
//

import SwiftUI
import AVKit
struct PlayerView : View {
    
    @Binding var data : [Video]
    @Binding var business : [Business]
    var body: some View{
        
        VStack(spacing: 0){
            
            ForEach(0..<self.data.count){i in
                
                ZStack{
                    
                    Player(player: self.data[i].player )
                        // full screensize because were going to make paging...
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .offset(y: -5)
                        .foregroundColor(.white)
                    VStack {
                        Spacer()
                        HStack {
                            Text(business[i].businessName)
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        .padding(.horizontal)
                        HStack {
                            Text(business[i].bdesc)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    if self.data[i].replay{
                        
                        Button(action: {
                            
                            // playing the video again...
                            
                            self.data[i].replay = false
                            self.data[i].player.seek(to: .zero)
                            self.data[i].player.play()
                            
                        }) {
                            
                            Image(systemName: "goforward")
                                .resizable()
                                .frame(width: 55, height: 60)
                                .foregroundColor(.white)
                        }
                    }
                    
                }
            }
        }
        .onAppear {
            
            // doing it for first video because scrollview didnt dragged yet...
            if data.count > 0{
                self.data[0].player.play()
                
                self.data[0].player.actionAtItemEnd = .none
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.data[0].player.currentItem, queue: .main) { (_) in
                    
                    // notification to identify at the end of the video...
                    
                    // enabling replay button....
                    self.data[0].replay = true
                }
            }
            
            
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(data: Binding.constant([Video(player: AVPlayer(url: URL(string: "https://www.tencil.co.uk//wp-content//uploads//2021//05//Vision-Critical-Crew-Clothing-Case-Study.mp")!), replay: false)]), business: Binding.constant([Business(businessID: "", businessName: "CM Stores", bdesc: "its the most popular store in Ottapalam city.", catID: "", featured: "", businessImg: "", businessWebsite: "", businessWebsiteSocial: "", careers: "", contact: "", videos: "", news: "")]))
    }
}
