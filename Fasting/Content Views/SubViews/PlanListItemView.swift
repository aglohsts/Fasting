//
//  PlanListItemView.swift
//  Fasting
//
//  Created by lohsts on 2021/11/8.
//

import SwiftUI

struct PlanListItemView: View {
    @ObservedObject var manager: FastingDataManager
    @State var isExpanded = false
    @StateObject var plan: Plan
    
    var body: some View {
        VStack(alignment: .center, spacing: 6, content: {
            HStack {
                TagView(text: plan.tag.rawValue.capitalized)
                    .padding([.top, .leading, .trailing])
                
                Spacer()
                
                Button(action: {
                    if !plan.isChosen {
                        manager.planData.forEach {
                            if $0.isChosen {
                                $0.isChosen = false
                            }
                        }
                        plan.isChosen.toggle()
                        manager.currentPlan = plan
                        UINotificationFeedbackGenerator().notificationOccurred(.success)
                    }
                }, label: {
                    Image(systemName: "checkmark")
                    .foregroundColor(.white)
                })
                .frame(width: 16, height: 16, alignment: .center)
                .padding(7)
                .background(plan.isChosen ? Color.red : Color.gray.opacity(0.4))
                .background(Color.white)
                .clipShape(Circle())
                .padding([.top])
                
                Button(action: {
                    plan.isFavorite.toggle()
                }, label: {
                    plan.isFavorite ? Image(systemName: "heart.fill").foregroundColor(.red) : Image(systemName: "heart.fill")
                        .foregroundColor(.gray.opacity(0.4))
                })
                .frame(width: 16, height: 16, alignment: .center)
                .padding(7)
                .background(Color.white)
                .clipShape(Circle())
                .padding([.top, .trailing])
            }
            
            HStack {
                Text(plan.name)
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .padding([.leading, .trailing])
                Spacer()
            }
            
            HStack(alignment: .top, spacing: 8, content: {
                Image(systemName: "clock")
                    .foregroundColor(.white)
                    .frame(width: 12, height: 12, alignment: .center)
                    .padding([.top], 4)
                    .padding([.leading])
                    .padding([.trailing], 6)
                Text(plan.description)
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(isExpanded ? nil : 3)
                    .padding([.trailing])
                Spacer()
            })
            
            if isExpanded {
                HStack {
                    Text(plan.detail)
                        .fontWeight(.regular)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .lineLimit(nil)
                        .padding()
                    Spacer()
                }
            }
            
            if isExpanded {
                Spacer()
                
                Button(action: {
                    if !plan.isChosen {
                        manager.planData.forEach {
                            if $0.isChosen {
                                $0.isChosen = false
                            }
                        }
                    }
                    
                    plan.isChosen.toggle()
                    manager.currentPlan = plan
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                }, label: {
                    if !plan.isChosen {
                        TagView(text: "Choose")
                    }
                })
                .padding([.bottom])
                
                Image(systemName: "chevron.compact.up")
                    .foregroundColor(.white)
                    .padding([.top], 4)
                    .padding([.bottom], 16)
            } else {
                Spacer()
                Image(systemName: "chevron.compact.down")
                    .foregroundColor(.white)
                    .padding([.top], 4)
                    .padding([.bottom], 16)
            }
        })
        .frame(width: (UIScreen.main.bounds.width - 32), height: isExpanded ? (UIScreen.main.bounds.height * 0.5) : 190)
        .background(backgroundView)
        .cornerRadius(30)
        .animation(.spring())
        .onTapGesture {
            withAnimation {
                self.isExpanded.toggle()
            }
        }
    }
    
    private var backgroundView: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(plan.name)
                    .fontWeight(.black)
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .opacity(0.1)
                    .padding([.trailing])
            }
        }
        .background(
            LinearGradient(gradient: plan.gradient, startPoint: .top, endPoint: .bottom)
                .mask(RoundedRectangle(cornerRadius: 30))
        )
        
    }
}

struct PlanListItemView_Previews: PreviewProvider {
    static var previews: some View {
        PlanListItemView(manager: FastingDataManager(), plan: Plan(content: .fourteen))
    }
}
