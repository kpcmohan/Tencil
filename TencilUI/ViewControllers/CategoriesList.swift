//
//  CategoriesList.swift
//  TencilUI
//
//  Created by Chandra Mohan on 18/07/21.
//

import SwiftUI

struct CategoriesList: View {
    @Binding var categoryTitle : String
    @Binding var business : [Business]
    @State var navToDetails = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                    VStack {
                        ForEach (business){ bus in
                                CategoryListCardView(title: bus.businessName, width: UIScreen.main.bounds.width * 0.85, bgColor: Color.contactButtonColor, imgURL: bus.businessImg)
                                    .onTapGesture {
                                        navToDetails = true
                                    }
                                        .shadow(radius: 5)
                                    .fullScreenCover(isPresented: $navToDetails, content: {
                                        DetailsView(business: bus)
                                    })
                            
                        }
                        
                    }
                })
            .padding()
            .navigationTitle(categoryTitle)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image.back
                    .renderingMode(.original)
            }))
        }
    }
}

struct CategoriesList_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesList(categoryTitle: Binding.constant("String"), business: Binding.constant([Business(businessID: "", businessName: "test", bdesc: "", catID: "", featured: "", businessImg: "", businessWebsite: "", businessWebsiteSocial: "", careers: "", contact: "", videos: "", news: "")]))
    }
}
