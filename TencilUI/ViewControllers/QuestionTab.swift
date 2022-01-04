//
//  QuestionTab.swift
//  TencilUI
//
//  Created by Chandra Mohan on 04/07/21.
//

import SwiftUI

struct QuestionTab: View {
    @State var question : String
    @State var answers : [String]
    @State var selectedAnswer = "Select an answer"
    @State var isExpanded = false
    @State var allCategories = [Category]()
    @State var selectedCategory = [Category]()
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                HStack {
                    Spacer()
                    VStack{
                            HStack {
                                Text(question)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                Spacer()
                            }
                            DisclosureGroup(selectedAnswer, isExpanded: $isExpanded) {
                                ScrollView {
                                    VStack {
                                        ForEach(answers,id : \.self){ answer in
                                            
                                            Text(answer)
                                                .fontWeight(.medium)
                                                .font(.callout)
                                                .onTapGesture {
                                                    selectedAnswer = answer
                                                    if allCategories.count > 0{
                                                        self.selectedCategory = allCategories.filter({$0.name == answer})
                                                        UserDefaults.standard.setValue(self.selectedCategory.first?.cid, forKey: String.userDefaultKeys.selectedCategory)
                                                    }
                                                    withAnimation {
                                                        isExpanded = false
                                                    }
                                                        
                                                }
                                                .padding()
                                                
                                        }
                                    }
                                }.frame(height: 200, alignment: .center)
                                
                            }
                            .frame(width: geometry.size.width * 0.6)
                            .padding()
                            .background(Color.primary)
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .cornerRadius(15)
                            
                            Spacer()
                        }
                    .frame(width: geometry.size.width * 0.8)
                .padding()
                    Spacer()
                }
            }
        }
    }
}

struct QuestionTab_Previews: PreviewProvider {
    static var previews: some View {
        QuestionTab(question: "Question 1", answers: ["1","2","3"])
    }
}
