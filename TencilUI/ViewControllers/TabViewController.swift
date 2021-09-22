//
//  TabViewController.swift
//  TencilUI
//
//  Created by Chandra Mohan on 12/09/21.
//

import SwiftUI

struct TabViewController: View {
    var body: some View {
        TabView {
                   HomeView()
                       .tabItem {
                           Label("Home", systemImage: "house.fill")
                       }
            Questionnaire(fromHome: Binding.constant(false))
                .tabItem {
                    Label("Questions", systemImage: "text.bubble.fill")
                }
            ProfileView(email: "steve@yopmail.com", name: "steve", password: "123456")
                       .tabItem {
                           Label("Me", systemImage: "person.fill")
                       }
               }
    }
}

struct TabViewController_Previews: PreviewProvider {
    static var previews: some View {
        TabViewController()
    }
}
