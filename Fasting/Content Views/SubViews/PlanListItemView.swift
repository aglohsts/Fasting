//
//  PlanListItemView.swift
//  Fasting
//
//  Created by lohsts on 2021/11/8.
//

import SwiftUI

struct PlanListItemView: View {
    @State var isExpanded = false
    @StateObject var planContent: Plan
    var backgroundGradient: Gradient
    
    var body: some View {
        VStack(alignment: .center, spacing: 6, content: {
            HStack {
                TagView(text: planContent.tag.rawValue.capitalized)
                    .padding([.top, .leading, .trailing])
                
                Spacer()
                
                Button(action: {
                    planContent.isFavorite.toggle()
                }, label: {
                    planContent.isFavorite ? Image(systemName: "heart.fill").foregroundColor(.red) : Image(systemName: "heart.fill")
                        .foregroundColor(.gray.opacity(0.4))
                })
                .padding(7)
                .background(Color.white)
                .clipShape(Circle())
                .padding([.top, .trailing])
            }
            
            HStack {
                Text(planContent.name)
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .padding([.leading, .trailing])
                Spacer()
            }
            
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(.white)
                    .frame(width: 12, height: 12, alignment: .center)
                    .padding([.leading])
                    .padding([.trailing], 6)
                Text(planContent.description)
                    .fontWeight(.medium)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(isExpanded ? nil : 2)
                    .padding([.trailing])
                Spacer()
            }
            
            if isExpanded {
                HStack {
                    Text(planContent.detail)
                        .fontWeight(.regular)
                        .font(.headline)
                        .foregroundColor(.white)
                        .lineLimit(nil)
                        .padding()
                    Spacer()
                }
            }
            
            Spacer()
            
            if isExpanded {
                Spacer()
                Image(systemName: "chevron.compact.up")
                    .foregroundColor(.white)
                    .padding([.top], 4)
                    .padding([.bottom], 16)
            } else {
                Image(systemName: "chevron.compact.down")
                    .foregroundColor(.white)
                    .padding([.top], 4)
                    .padding([.bottom], 16)
            }
        })
        .frame(width: (UIScreen.main.bounds.width - 32), height: isExpanded ? (UIScreen.main.bounds.height * 0.4) : 160)
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
                Text(planContent.name)
                    .fontWeight(.black)
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .opacity(0.1)
                    .padding([.trailing])
            }
        }
        .background(
            LinearGradient(gradient: backgroundGradient, startPoint: .top, endPoint: .bottom)
                .mask(RoundedRectangle(cornerRadius: 30))
        )
        
    }
}

struct PlanListItemView_Previews: PreviewProvider {
    static var previews: some View {
        PlanListItemView(planContent: Plan(tag: .beginner, name: "test name", description: "test description description description description description description description description ", detail: "test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail"), backgroundGradient: Gradient(colors: [Color(#colorLiteral(red: 0.4847264653, green: 0.4169784902, blue: 0.6716101926, alpha: 1)), Color(#colorLiteral(red: 0.3965855241, green: 0.3398780823, blue: 0.5469947457, alpha: 1))])).previewLayout(.sizeThatFits)
    }
}
