//
//  Questionnaire.swift
//  TencilUI
//
//  Created by Chandra Mohan on 04/07/21.
//

import SwiftUI

struct Questionnaire: View {
    @Binding var fromHome : Bool
    @State var questions = ["Q1: Where Do You Live?",
                            "Q2: How Old Are You?",
                            "Q3: What Gender Are You?",
                            "Q4: Which Ethic Group Best  Describes You?",
                            "Q5: What Is Your Favourite Subjects?",
                            "Q6: What Is Your Favourite Hobby?",
                            "Q7: What Is Your Favourite Sport?",
                            "Q8: What Is Your Favourite Social Media?",
                            "Q9: What Is Your Favourite Music Genre?",
                            "Q10: What Is Your Favourite Console?",
                            "Q11: What statement best describes you?",
                            "Q12: What do you want to do after you leave school?",
                            "Q13: What Career Are You Most Interested In?"
                        ]
    @State var answers = [
        ["Wales", "England", "Scotland", "Northern Ireland", "Other" ],
        [ "13-14", "15-16", "16-17", "18+", "Prefer not to say"],
        ["Male", "Female", "Others"],
        ["White", "Asian", "Black", "Mixed Race", "Other", "Prefer Not To Say"],
        ["Humanities", "Sciences", "Social Sciences", "Languages", "Mathematics"],
        ["Sports",
         "Social Media",
         "Music",
         "Gaming",
         "Technology",
         "Arts and Design",
         "Other"],
        ["Rugby",
         "Football",
         "Cricket",
         "Golf",
         "Hiking",
         "Swimming",
         "Ballet",
         "Other"],
        ["Facebook",
         "Twitter",
         "TikTok",
         "Instagram",
         "Snapchat",
         "Youtube",
         "Linkedin",
         "Other"],
        ["Hip Hop",
         "Pop Music",
         "House Music",
         "Techno",
         "Jazz",
         "Rock",
         "Heavy Metal",
         "Other"],
        ["Playstation",
         "Xbox",
         "PC",
         "Nintendo",
         "Other",
         "None"],
        [ "I Am Passionate About My Work",
          "I Am Highly Organised.",
          "I Am Ambitious And Driven",
          "I am a People Person",
          "Im a Natural Leader",
          "I am Results Orientated"],
        [ "University",
          "Apprenticeship",
          "Full-Time Work",
          "Part-Time Work",
          "Travelling",
          "I am Results Orientated"],
        [ "Coding",
          "Edtech",
          "Communication Companies",
          "Consultancy",
          "Fintech",
          "Other",
          "Marketing",
          "Property",
          "Utilities",
          "Health & Care",
          "Food",
          "Law",
          "Sport",
          "Education",
          "Finance",
          "Fashion",
          "Travel",
          "Gaming",
          "Music"]
        
    ]
    @State var selectedTab = 0
    @State var showLogin = false
    var body: some View {
        NavigationView {
            VStack{
                TabView(selection: $selectedTab,
                        content:  {
                            ForEach(0...12,id : \.self){ index in
                                QuestionTab(question: questions[index], answers: answers[index])
                            }
                        })
                .tabViewStyle(PageTabViewStyle())
                HStack{
                    Button(action: {
                        withAnimation {
                            selectedTab -= 1
                        }
                    }, label: {
                        if selectedTab > 0{
                            CustomButton(width: 150, title: .previous.uppercased())
                        }
                    })
                    
                    Button(action: {
                        withAnimation {
                            if selectedTab < 12{
                                selectedTab += 1
                            }
                            else{
                                UserDefaults.standard.setValue(true, forKey: String.userDefaultKeys.questionnaireCompleted)
                                if fromHome{
                                    fromHome = false
                                }
                                else{
                                    showLogin = true
                                }
                            }
                        }
                    }, label: {
                        if selectedTab < 12{
                            CustomButton(width: 150, title: .next.uppercased())
                        }
                        else{
                            CustomButton(width: 150, title: .submit.uppercased())
                        }
                        
                    })
                    .padding()
                }
                Spacer()
            }
            .fullScreenCover(isPresented: $showLogin, content: {
                LoginView(email: "", password: "", homeView: false, registerView: false, activateView: false, forgotPasswordView: false, isShowingPopUp: false, isLoading: false)
            })
            .navigationBarItems(trailing: Button(action: {
                UserDefaults.standard.setValue(false, forKey: String.userDefaultKeys.questionnaireCompleted)
                if fromHome{
                    fromHome = false
                }
                else{
                    showLogin = true
                }
            }, label: {
                Text("Skip")
                    .foregroundColor(.black)
            }))
        }
    }
}

struct Questionnaire_Previews: PreviewProvider {
    static var previews: some View {
        Questionnaire(fromHome: Binding.constant(false))
    }
}
