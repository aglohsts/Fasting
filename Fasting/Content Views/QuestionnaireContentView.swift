//
//  QuestionnaireContentView.swift
//  Fasting
//
//  Created by Apps4World on 2/4/21.
//

import SwiftUI

/// Basic answers for the generic fasting question
enum QuestionnaireAnswer: String, CaseIterable, Identifiable {
    case newbie = "Never heard"
    case read = "Only read about it"
    case expert = "I'm an expert"
    var id: Int { hashValue }
}

/// Second screen asking the user if they know anything about fasting
struct QuestionnaireContentView: View {
    
    @ObservedObject var manager: FastingDataManager
    
    // MARK: - Main rendering function
    var body: some View {
        VStack(alignment: .leading) {
            Text("Have you heard about intermittent fasting?")
                .font(.largeTitle).bold()
            VStack {
                ForEach(QuestionnaireAnswer.allCases, content: { item in
                    createAnswer(item: item)
                })
            }.padding(.top, 50)
            Spacer()
            Button(action: {
                manager.didShowQuestionnaire = true
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                    Text("Next").foregroundColor(.white).bold()
                }
            })
            .disabled(manager.selectedAnswer == nil)
            .frame(height: 50)
        }
        .multilineTextAlignment(.leading)
        .padding([.leading, .trailing, .bottom], 40)
    }
    
    private func createAnswer(item: QuestionnaireAnswer) -> some View {
        Button(action: {
            manager.selectedAnswer = item
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(manager.selectedAnswer == item ? .accentColor : Color(#colorLiteral(red: 0.8915459514, green: 0.8915459514, blue: 0.8915459514, alpha: 1)))
                Text(item.rawValue).font(.title3).bold()
                    .foregroundColor(manager.selectedAnswer == item ? .white : .black)
            }
        }).frame(height: 55)
    }
}

// MARK: - Render preview UI
struct QuestionnaireContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireContentView(manager: FastingDataManager())
    }
}
