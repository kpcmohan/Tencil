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
    var body: some View {
           // NavigationView{
                ZStack {

                    if isShowing{
                        SlideMenuView(isShowing: $isShowing)
                    }
                    HomeViewF(business: $business, categories: $categories, recommendedBusiness: $recommendedBusiness, selectedCategory: $selectedCategory)
                        .cornerRadius(isShowing ? 20 : 10)
                        .offset(x: isShowing ? 300 : 0, y: isShowing ? 44 : 0)
                        .scaleEffect(isShowing ? 0.8 : 1)
                        //.navigationBarItems(leading:
                                               
                        //)
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
                }
                .background(Color.black.edgesIgnoringSafeArea(.all))
                .edgesIgnoringSafeArea(.all)
                .fullScreenCover(isPresented: $navToQA, content: {
                    Questionnaire(fromHome: $navToQA)
                })
          //  }
            .navigationViewStyle(StackNavigationViewStyle())
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

struct Video : Identifiable {
    
    var id : Int
    var player : AVQueuePlayer
    var replay : Bool
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct HomeViewF: View {
    @Binding var business : [Business]{
        willSet{
            var i = 0
            for  one in newValue {
                data.append(Video(id: i, player: AVQueuePlayer(url: URL(string: one.videos)!), replay: false))
                i = i + 1
            }
        }
    }
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

            PlayerViewContainer(videoData: $data)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
        
    }
}
struct PlayerScrollView : UIViewRepresentable {
    
    
    func makeCoordinator() -> Coordinator {
        
        return PlayerScrollView.Coordinator(parent1: self)
    }
    
    @Binding var data : [Video]
    
    func makeUIView(context: Context) -> UIScrollView{
        
        let view = UIScrollView()
        
        let childView = UIHostingController(rootView: PlayerView(data: self.$data))
        
        // each children occupies one full screen so height = count * height of screen...
        
        childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        
        // same here...
        
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        
        view.addSubview(childView.view)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        // to ignore safe area...
        view.contentInsetAdjustmentBehavior = .never
        view.isPagingEnabled = true
        view.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
        // to dynamically update height based on data...
        
        uiView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        
        for i in 0..<uiView.subviews.count{
            
            uiView.subviews[i].frame = CGRect(x: 0, y: 0,width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        }
    }
    
    class Coordinator : NSObject,UIScrollViewDelegate{
        
        var parent : PlayerScrollView
        var index = 0
        
        init(parent1 : PlayerScrollView) {
            
            parent = parent1
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            
            let currenrindex = Int(scrollView.contentOffset.y / UIScreen.main.bounds.height)
            
            if index != currenrindex{
                
                index = currenrindex
                
                for i in 0..<parent.data.count{
                    
                    // pausing all other videos...
                    parent.data[i].player.seek(to: .zero)
                    parent.data[i].player.pause()
                }
                
                // playing next video...
                
                parent.data[index].player.play()
                
                parent.data[index].player.actionAtItemEnd = .none
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: parent.data[index].player.currentItem, queue: .main) { (_) in
                    
                    // notification to identify at the end of the video...
                    
                    // enabling replay button....
                    self.parent.data[self.index].replay = true
                }
            }
        }
    }
    
    
}
struct Player : UIViewControllerRepresentable {
    
    var player : AVQueuePlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController{
        
        let view = AVPlayerViewController()
        view.player = player
        view.showsPlaybackControls = false
        view.videoGravity = .resizeAspectFill
        view.player?.play()
        return view
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
        
    }
}
struct PlayerView : View {
    
    @Binding var data : [Video]
    
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
                            Text("Demo")
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        .padding(.horizontal)
                        HStack {
                            Text("Testing")
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
