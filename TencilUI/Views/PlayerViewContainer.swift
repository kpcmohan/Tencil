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
    var body: some View {
        ZStack{
            PlayerScrollView(data: $videoData)
        }
        
    }
}

struct PlayerViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        PlayerViewContainer(videoData: Binding.constant([Video(id: 1, player: AVQueuePlayer(url: URL(string: "https://www.tencil.co.uk//wp-content//uploads//2021//05//Vision-Critical-Crew-Clothing-Case-Study.mp4")!), replay: false)]))
    }
}
