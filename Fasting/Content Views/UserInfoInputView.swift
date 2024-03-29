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
    
    var genderOptions: [Gender] = [.other, .male, .female]
        
    var body: some View {
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
                        }).onChange(of: selectedGenderIndex, perform: { value in
                            manager.userInfo.gender = genderOptions[selectedGenderIndex]
                        })
                    }
                }
                
                Section {
                    FormLabelView(titleText: "Age", iconSystemName: "clock.fill", backgroundColor: .blue)
                    TextField("Please input your age.", text: $manager.userInfo.age)
                        .keyboardType(.numberPad)
                }
                
                Section {
                    FormLabelView(titleText: "Height (cm)", iconSystemName: "ruler.fill", backgroundColor: .blue)
                    TextField("Please input your height.", text: $manager.userInfo.height)
                        .keyboardType(.numberPad)
                }
                
                Section {
                    FormLabelView(titleText: "Weight (kg)", iconSystemName: "lineweight", backgroundColor: .blue)
                    TextField("Please input your weight.", text: $manager.userInfo.weight)
                        .keyboardType(.numberPad)
                }
                
                Section {
                    FormLabelView(titleText: "Fat (%)", iconSystemName: "deskclock.fill", backgroundColor: .blue)
                    TextField("Please input your fat %.", text: $manager.userInfo.fat)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle(Text(title))
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Button(action: {
                        if !manager.didShowWelcomePage {
                            manager.didShowWelcomePage = true
                        }
                        
                        manager.saveUserInfo()
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text(buttonText)
                    })
                    .disabled(!manager.userInfo.checkInputDone())
                }
            }
    }
}

struct UserInfoInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoInputView(manager: FastingDataManager(), title: "title", buttonText: "Save")
    }
}
