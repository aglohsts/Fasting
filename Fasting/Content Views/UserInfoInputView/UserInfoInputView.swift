//
//  UserInfoInputView.swift
//  Fasting
//
//  Created by lohsts on 2021/10/17.
//

import SwiftUI

struct UserInfoInputView: View {
    @ObservedObject var manager: FastingDataManager
    var title: String
    var buttonText: String
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedGenderIndex = 0
    @State private var isGenderPickerShow = false
    
    var genderOptions: [Gender] = [.unknown, .male, .female]
        
    var body: some View {
        NavigationView {
            Form {
                Section {
                    FormLabelView(titleText: "User Name", iconSystemName: "person.fill", backgroundColor: .blue)
                    TextField("Please input your user name.", text: $manager.userInfo.username)
                    .autocapitalization(.words)
                }
                
                Section {
                    HStack {
                        FormLabelView(titleText: "Gender", iconSystemName: "heart.text.square.fill", backgroundColor: .blue)
                        Spacer()
                        Picker(selection: $selectedGenderIndex, label: Text(""), content: {
                            ForEach(0 ..< genderOptions.count) {
                                Text(self.genderOptions[$0].rawValue).tag($0)
                            }
                        })
                    }
                }
                
                Section {
                    FormLabelView(titleText: "Age", iconSystemName: "clock.fill", backgroundColor: .blue)
                    TextField("Please input your age.", value: $manager.userInfo.age, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                
                Section {
                    FormLabelView(titleText: "Height", iconSystemName: "ruler.fill", backgroundColor: .blue)
                    TextField("Please input your height.", value: $manager.userInfo.height, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                
                Section {
                    FormLabelView(titleText: "Weight", iconSystemName: "lineweight", backgroundColor: .blue)
                    TextField("Please input your weight.", value: $manager.userInfo.height, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle(Text(title))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Button(action: {
                        manager.saveUserInfo()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text(buttonText)
                    })
                    
                }
            }
        }
    }
}

struct UserInfoInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoInputView(manager: FastingDataManager(), title: "title", buttonText: "Save")
    }
}
