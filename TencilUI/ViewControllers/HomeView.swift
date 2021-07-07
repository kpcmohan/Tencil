//
//  HomeView.swift
//  TencilUI
//
//  Created by  on 10/06/21.
//

import SwiftUI

struct HomeView: View {
    @State var isShowing = false
    @State var categories = [Category]()
    @State var business = [Business]()
    @State var showQA = !UserDefaults.standard.bool(forKey: String.userDefaultKeys.questionnaireCompleted)
    @State var navToQA = false
    var body: some View {
            NavigationView{
                ZStack {
                    if isShowing{
                        SlideMenuView(isShowing: $isShowing)
                    }
                    HomeViewF(business: $business, categories: $categories)
                        .cornerRadius(isShowing ? 20 : 10)
                        .offset(x: isShowing ? 300 : 0, y: isShowing ? 44 : 0)
                        .scaleEffect(isShowing ? 0.8 : 1)
                        .navigationBarItems(leading:
                                                Button(action: {
                                                    withAnimation(.spring()) {
                                                        isShowing.toggle()
                                                    }
                                                    
                                                }, label: {
                                                    Image.menu
                                                        .resizable()
                                                        .frame(width: 20, height: 20, alignment: .center)
                                                        .foregroundColor(.black)
                                                        .padding(.top, 20)
                                                })
                        )
                        .navigationBarItems(trailing: Button(action: {
                            if showQA{
                                navToQA = true
                            }
                            
                        }, label: {
                            if showQA{
                                Image.question
                                    .accentColor(.black)
                            }
                        }))
                }
                .fullScreenCover(isPresented: $navToQA, content: {
                    Questionnaire(fromHome: $navToQA)
                })
            }
            .onAppear(){
                Api().getBusiness { business in
                    self.business = business.businesses
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
    }
}

struct HomeViewF: View {
    @Binding var business : [Business]
    @Binding var categories : [Category]
    
    var body: some View {
        ZStack {
            Color.white
            ScrollView(showsIndicators: false ){
                Text(String.welcomeTencil)
                    .foregroundColor(.black)
                    .font(.system(size: 30 , weight: .semibold))
                    .padding([.horizontal], 20)
                Text(String.weRecommend)
                    .foregroundColor(.black)
                    .font(.system(size: 25 , weight: .semibold))
                    .padding([.horizontal,.top,.bottom], 20)
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    LazyHStack(alignment: .center, spacing: nil, pinnedViews: [], content: {
                        ForEach(business) { bus in
                            HorizontalCardView(title:bus.businessName, width: UIScreen.main.bounds.width * 0.85, showImage: true, bgColor: Color.horizontalCBC, imgURL: bus.businessImg)
                                    .shadow(radius: 5)
                        }
                    })
                })
                .padding()
                
                
                HStack {
                    StaticCardView(title: .allFeaturedCompanies, description: .allFeaturedCompaniesDescription, width: UIScreen.main.bounds.width / 2.8)
                        .padding([.vertical , .leading])
                        .shadow(radius: 1)
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack {
                            
                            ForEach (business){bis in
                                NavigationLink(destination: DetailsView(business: bis)){
                                    CardView(imageURL: bis.businessImg, title: bis.businessName, description: bis.bdesc, width: UIScreen.main.bounds.width / 2.8)
                                        .padding()
                                        .shadow(radius: 5)
                                }
                                .foregroundColor(.black)
                            }
                        }.padding()
                    })
                }
                HStack{
                    Text(String.categories.uppercased())
                        .font(.system(size: 30,weight: .bold))
                        .padding()
                    Spacer()
                }
                
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack {
                            ForEach (categories){ cat in
                                HorizontalCardView(title: cat.name?.uppercased() ?? "", width: UIScreen.main.bounds.width * 0.85, showImage: false, bgColor: Color.buttonBGC, imgURL: "")
                                .shadow(radius: 5)
                                
                            }
                        }
                    })
                
                    .padding()
                    Spacer()
            }
        }
    }
}
