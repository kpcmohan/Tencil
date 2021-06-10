//
//  HomeView.swift
//  TencilUI
//
//  Created by Manu Puthoor on 10/06/21.
//

import SwiftUI

struct HomeView: View {
    @State var isShowing = false
    var body: some View {
            NavigationView{
                ZStack {
                    if isShowing{
                        SlideMenuView(isShowing: $isShowing)
                    }
                    HomeViewF()
                        .cornerRadius(isShowing ? 20 : 10)
                        .offset(x: isShowing ? 300 : 0, y: isShowing ? 44 : 0)
                        .scaleEffect(isShowing ? 0.8 : 1)
                        .navigationBarItems(leading:
                                                Button(action: {
                                                    withAnimation(.spring()) {
                                                        isShowing.toggle()
                                                    }
                                                    
                                                }, label: {
                                                    Image(systemName: "list.dash")
                                                        .resizable()
                                                        .frame(width: 20, height: 20, alignment: .center)
                                                        .foregroundColor(.black)
                                                        .padding(.top, 20)
                                                })
                        )
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
    var body: some View {
        ZStack {
            Color.white 
            GeometryReader{ geometry in
                ScrollView(showsIndicators: false ){
                    Text("Welcom to Tencil")
                        .foregroundColor(.black)
                        .font(.system(size: 30 , weight: .semibold))
                        .padding([.horizontal], 20)
                    Text("We Recommend")
                        .foregroundColor(.black)
                        .font(.system(size: 25 , weight: .semibold))
                        .padding([.horizontal,.top,.bottom], 20)
                    
                    HorizontalCardView(title: "Provide", width: 350, showImage: true, bgColor: "HCardBG")
                        .shadow(radius: 5)
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack {
                            StaticCardView(title: "ALL FETURED COMPANIES", description: "All the fetured companes have a top demand in your area!")
                                .padding()
                                .shadow(radius: 1)
                            ForEach (0..<5){i in
                                CardView(image: "person", title: "Amazon", description: "Testing description for demo")
                                    .padding()
                                    .shadow(radius: 5)
                                
                            }
                        }.padding()
                    })
                    HStack{
                        Text("CATEGORIES")
                            .font(.system(size: 30,weight: .bold))
                            .padding()
                        Spacer()
                    }
                    HorizontalCardView(title: "CODING", width: 330, showImage: false, bgColor: "ButtonBG")
                        .shadow(radius: 5)
                    
                }
            }
            
        }
    }
}
