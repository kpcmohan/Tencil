//
//  Color+Ext.swift
//  TencilUI
//
//  Created by on 10/06/21.
//

import SwiftUI
import CryptoKit
import Foundation
import UIKit
extension Color{
    
    static let buttonBGC = Color("ButtonBG")
    static let horizontalCBC = Color("HCardBG")
    static let slideMenuC = Color("SlideMenuColour")
    static let staticCVBGC = Color("StaticHCVBG")
    static let titleFC = Color("TitleFC")
    static let buttonColor = Color("ButtonColor")
    static let careerButtonColor = Color("CareerButtonColor")
    static let contactButtonColor = Color("ContactButtonColor")
    
    
    
}
extension Data {
    var md5: String {
        Insecure.MD5
            .hash(data: self)
            .map {String(format: "%02x", $0)}
            .joined()
    }
}
