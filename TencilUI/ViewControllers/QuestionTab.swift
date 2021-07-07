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
    var body: some View {
        ZStack{
                VStack{
                    Text(question)
                        .fontWeight(.bold)
                        .font(.title)
                        .padding()
                    DisclosureGroup(selectedAnswer, isExpanded: $isExpanded) {
                        ScrollView {
                            VStack {
                                ForEach(answers,id : \.self){ answer in
                                    
                                    Text(answer)
                                        .fontWeight(.medium)
                                        .font(.title2)
                                        .onTapGesture {
                                            selectedAnswer = answer
                                            withAnimation {
                                                isExpanded = false
                                            }
                                                
                                        }
                                        .padding()
                                        
                                }
                            }
                        }.frame(height: 200, alignment: .center)
                        
                    }
                    .padding()
                    .background(Color.primary)
                    .foregroundColor(.white)
                    .accentColor(.white)
                    .cornerRadius(15)
                    
                    Spacer()
                }
                .padding()
        }
    }
}

struct QuestionTab_Previews: PreviewProvider {
    static var previews: some View {
        QuestionTab(question: "Question 1", answers: ["1","2","3"])
    }
}
