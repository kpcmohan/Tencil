//
//  PlayerViewContainer.swift
//  TencilUI
//
//  Created by Chandra Mohan on 22/09/21.
//

import SwiftUI
import AVKit
struct PlayerViewContainer: View {
    @Binding var videoData : [Video]
    @Binding var business : [Business]
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                PlayerScrollView(data: $videoData, business: $business)
                    .ignoresSafeArea()
                    .background(Color.black)
            }
            
            
        }
    }
}

struct PlayerViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        PlayerViewContainer(videoData: Binding.constant([Video(player: AVPlayer(url: URL(string: "https://www.tencil.co.uk//wp-content//uploads//2021//05//Vision-Critical-Crew-Clothing-Case-Study.mp")!), replay: false)]), business: Binding.constant([Business(businessID: "", businessName: "", bdesc: "", catID: "", featured: "", businessImg: "", businessWebsite: "", businessWebsiteSocial: "", careers: "", contact: "", videos: "", news: "")]))
    }
}
