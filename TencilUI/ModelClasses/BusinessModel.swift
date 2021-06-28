//
//  BusinessModel.swift
//  TencilUI
//
//  Created by Manu Puthoor on 26/06/21.
//

import Foundation


// MARK: - BusinessModel
struct BusinessModel: Codable{
   
    let businesses: [Business]
}

// MARK: - Business
struct Business: Codable, Identifiable {
    let id = UUID()
    let businessID, businessName, bdesc, catID: String
    let featured: String
    let businessImg: String
    let businessWebsite: String
    let businessWebsiteSocial: String
    let careers, contact: String
    let videos: String
    let news: String

    enum CodingKeys: String, CodingKey {
        case businessID = "business_id"
        case businessName = "business_name"
        case bdesc
        case catID = "cat_id"
        case featured
        case businessImg = "business_img"
        case businessWebsite = "business_website"
        case businessWebsiteSocial = "business_website_social"
        case careers, contact, videos, news
    }
}
