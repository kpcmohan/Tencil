//
//  Player.swift
//  TencilUI
//
//  Created by Chandra Mohan on 22/09/21.
//

import Foundation
import SwiftUI
import AVKit
struct Player : UIViewControllerRepresentable {
    
    var player : AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController{
        
        let view = AVPlayerViewController()
        view.player = player
        view.showsPlaybackControls = false
       // view.videoGravity = .resizeAspectFill
        return view
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
        
    }
}
