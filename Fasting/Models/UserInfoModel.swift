//
//  UserInfoModel.swift
//  Fasting
//
//  Created by lohsts on 2021/10/17.
//

import Foundation
import SwiftUI

class UserInfo: ObservableObject {
    var gender = Gender.unknown
    var age: Int = 18
    var height: Int = 170
    var weight: Double = 60.0
    var fat: Double = 15.0
}

enum Gender: String {
    case male
    case female
    case unknown
}
