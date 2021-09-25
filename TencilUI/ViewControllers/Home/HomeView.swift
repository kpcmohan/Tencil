//
//  HomeView.swift
//  TencilUI
//
//  Created by  on 10/06/21.
//

import SwiftUI
import AVKit

struct HomeView: View {
    
    @State var isShowing = false
    @State var categories = [Category]()
    @State var business = [Business]()
    @State var recommendedBusiness = [Business]()
    @State var showQA = !UserDefaults.standard.bool(forKey: String.userDefaultKeys.questionnaireCompleted)
    @State var selectedCategory = UserDefaults.standard.string(forKey: String.userDefaultKeys.selectedCategory)
    @State var navToQA = false
    @State var currentTab = "house.fill"
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        VStack(spacing: 0, content: {
            TabView(selection : $currentTab) {
                ReelsView( business: $business)
                    .tag("house.fill")
                Questionnaire(fromHome: Binding.constant(true))
                    .tag("text.bubble.fill")
                ProfileView(email: "", name: "", password: "")
                    .tag("person.fill")
            }
            HStack(spacing : 0){
                ForEach(["house.fill","text.bubble.fill","person.fill"], id: \.self) { image in
                    TabBarButton(image: image, currentTab: $currentTab)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .overlay(Divider(), alignment: .top)
            .background(Color.black.ignoresSafeArea())
        })
        .onAppear(){
            Api().getBusiness { business in
                self.business = business.businesses
                recommendedBusiness = self.business
                if selectedCategory != nil{
                    recommendedBusiness = self.business.filter({$0.catID == selectedCategory})
                    
                }
                Api().getCategories { categories in
                    self.categories = categories.categories
                }
            }
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        // .preferredColorScheme(.dark)
    }
}
struct ReelsView : View {
    @State var currentReel = ""
    @Binding var business : [Business]
    @State var reels = [Reel]()
    var body: some View{
        GeometryReader{ geo in
            let size = geo.size
            if reels.count > 0{
                TabView(selection: $currentReel){
                    ForEach(reels){ reel in
                        ReelsPlayer(reel: Binding.constant(reel))
                            .frame(width: size.width)
                            .rotationEffect(.init(degrees: -90))
                        // .ignoresSafeArea(.all,edges: .top)
                    }
                }
                .rotationEffect(.init(degrees: 90))
                .frame(width: size.height)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(width: size.width)
            }
        }
        //.ignoresSafeArea(.all,edges: .top)
        .background(Color.white.ignoresSafeArea())
        .onAppear(perform: {
            reels = business.map{item -> Reel in
                let url = item.videos
                let player = AVPlayer(url: URL(string: url)!)
                return Reel(player: player, business: item)
            }
        })
    }
    
}


struct Reel : Identifiable {
    var id = UUID().uuidString
    var player : AVPlayer?
    var business : Business
    
}
struct ReelsPlayer : View {
    @Binding var reel : Reel
    @State var showMore = false
    var body: some View{
        ZStack{
            if let player = reel.player{
                Player(player: player)
                VStack{
                    HStack(alignment : .bottom){
                        VStack(alignment : .leading,spacing : 10){
                            HStack(spacing : 10){
                                VStack(alignment:.leading,spacing: 5){
                                    Text(reel.business.businessName)
                                        .foregroundColor(.white)
                                        .font(.callout.bold())
                                    
                                    Button(action: {
                                        withAnimation{showMore.toggle()}
                                    }, label: {
                                        if showMore{
                                            ScrollView(.vertical, showsIndicators: false, content: {
                                                Text(reel.business.bdesc)
                                                    .foregroundColor(.white)
                                                    .font(.subheadline)
                                            })
                                            .frame(height: 120, alignment: .leading)
                                        }
                                        else{
                                            HStack{
                                                Text(reel.business.bdesc)
                                                    .foregroundColor(.white)
                                                    .font(.subheadline)
                                                    .lineLimit(1)
                                                Text("Show more")
                                                    .foregroundColor(.white)
                                                    .font(.subheadline)
                                            }
                                            .padding(.top, 6)
                                            .frame(maxWidth : .infinity,alignment: .leading)
                                        }
                                        
                                    })
                                }
                                .padding()
                                Spacer()
                            }
                        }
                    }
                }
                .frame(maxHeight : .infinity, alignment: .bottom)
            }
        }
    }
    
}
struct TabBarButton: View {
    var image : String
    @Binding var currentTab : String
    var body: some View{
        Button(action: {
            withAnimation {
                currentTab = image
                
            }
        }, label: {
            
            ZStack {
                Image(systemName: image)
                    .font(.title2)
            }
            .foregroundColor(currentTab == image ? .buttonColor : .gray)
            .frame(maxWidth : .infinity)
        })
    }
}


struct HomeViewF: View {
    @Binding var business : [Business]
    @State var filteredbusiness = [Business]()
    @Binding var categories : [Category]
    @Binding var recommendedBusiness : [Business]
    @Binding var selectedCategory : String?
    @State var navToDetails = false
    @State var navToCatList = false
    @State var playVidoes = false
    @State var data = [Video]()
    var body: some View {
        ZStack {
            //Player(player: AVPlayer(url: URL(string: "https://www.tencil.co.uk/wp-content/uploads/2021/05/Where-Pieminister-began-Stokes-Croft.mp4" )!))
            if business.count > 0 {
                PlayerViewContainer(videoData: $data, business: $business)
                    .onAppear(perform: {
                        for one in business{
                            self.data.append(Video(player: AVPlayer(url: URL(string: one.videos)!), replay: false))
                        }
                    })
            }
            
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
        
    }
}




/*
 ZStack {
 
 if isShowing{
 SlideMenuView(isShowing: $isShowing)
 }
 
 //            HomeViewF(business: $business, categories: $categories, recommendedBusiness: $recommendedBusiness, selectedCategory: $selectedCategory)
 //                .cornerRadius(isShowing ? 20 : 10)
 //                .offset(x: isShowing ? 300 : 0, y: isShowing ? 44 : 0)
 //                .scaleEffect(isShowing ? 0.8 : 1)
 VStack {
 HStack{
 Button(action: {
 withAnimation(.spring()) {
 isShowing.toggle()
 }
 
 }, label: {
 if !isShowing{
 Image.menu
 .resizable()
 .frame(width: 20, height: 20, alignment: .center)
 .foregroundColor(.white)
 .padding(.top, 20)
 }
 
 })
 Spacer()
 }
 .padding([.top, .leading], 40)
 Spacer()
 }
 Text("Hello")
 .foregroundColor(.white)
 }
 .background(Color.black.edgesIgnoringSafeArea(.all))
 .edgesIgnoringSafeArea(.all)
 .fullScreenCover(isPresented: $navToQA, content: {
 Questionnaire(fromHome: $navToQA)
 })
 //  }
 .navigationViewStyle(StackNavigationViewStyle())
 
 **/
