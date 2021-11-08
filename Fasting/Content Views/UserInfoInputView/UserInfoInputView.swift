//
//  UserInfoInputView.swift
//  Fasting
//
//  Created by lohsts on 2021/10/17.
//

import SwiftUI

struct UserInfoInputView: View {
    
    @StateObject var userInfo = UserInfo()
    @State private var selectedGenderIndex = 0
    @State private var isGenderPickerShow = false
    
    var genderOptions: [Gender] = [.unknown, .male, .female]
        
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        FormLabelView(titleText: "Gender", iconSystemName: "person.fill", backgroundColor: .blue)
                        Spacer()
                        Picker(selection: $selectedGenderIndex, label: Text(""), content: {
                            ForEach(0 ..< genderOptions.count) {
                                Text(self.genderOptions[$0].rawValue).tag($0)
                            }
                        })
                    }
                }
            }
            .navigationTitle(Text("Gender"))
        }
    }
}

struct UserInfoInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoInputView()
    }
}
