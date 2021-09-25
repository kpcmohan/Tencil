//
//  Video.swift
//  TencilUI
//
//  Created by Chandra Mohan on 22/09/21.
//

import Foundation
import AVKit
struct Video : Identifiable {
    
    var id = UUID().uuidString
    var player : AVPlayer
    var replay : Bool
}
