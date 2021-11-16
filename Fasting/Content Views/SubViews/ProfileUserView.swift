//
//  ProfileUserView.swift
//  Fasting
//
//  Created by lohsts on 2021/11/8.
//

import SwiftUI

struct ProfileUserView: View {
    @ObservedObject var manager: FastingDataManager
    @State var showingUserInputView = false
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 60))
                .foregroundColor(.black)
                .padding([.leading, .trailing], 16)
            VStack(alignment: .leading, spacing: 4, content:  {
                Text((manager.userInfo.username == "") ? "User" : manager.userInfo.username)
                    .font(.title)
                    .bold()
                    .padding([.bottom], 4)
                Button(action: {
                    showingUserInputView = true
                }, label: {
                    HStack {
                        Text((manager.userInfo.username == "") ? "Set User Info" : "Update User Info")
                            .foregroundColor(.gray)
                        Image(systemName: "square.and.pencil")
                    }
                }).sheet(isPresented: $showingUserInputView, content: {
                    NavigationView {
                        UserInfoInputView(manager: manager, title: "User Info", buttonText: "Save")
                    }
                    
                })
            })
            Spacer()
        }
        .padding([.top, .bottom], 10)
        .background(Color(#colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.9607843137, alpha: 1)).cornerRadius(8)).padding([.leading, .trailing])
    }
}

struct ProfileUserView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUserView(manager: FastingDataManager()).previewLayout(.sizeThatFits)
    }
}
