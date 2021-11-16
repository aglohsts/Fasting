//
//  UserInfoModel.swift
//  Fasting
//
//  Created by lohsts on 2021/10/17.
//

import Foundation
import SwiftUI

class UserInfo: ObservableObject, Codable {
    var username: String = ""
    var gender = Gender.other
    var age: String = ""
    var height: String = ""
    var weight: String = ""
    var fat: String = ""
    var bmi: String {
        if height != "" && weight != "", let heightN = Float(height), let weightN = Float(weight) {
            let bmiN = Int(weightN / (heightN / 100))^2
            return String(bmiN)
        }
        return ""
    }
    
    func checkInputDone() -> Bool {
        return username != "" && age != "" && height != "" && weight != "" && fat != ""
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case username
        case gender
        case age
        case height
        case weight
        case fat
        case bmi
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(username, forKey: CodingKeys.username)
        try container.encode(gender.rawValue, forKey: CodingKeys.gender)
        try container.encode(age, forKey: CodingKeys.age)
        try container.encode(height, forKey: CodingKeys.height)
        try container.encode(weight, forKey: CodingKeys.weight)
        try container.encode(fat, forKey: CodingKeys.fat)
        try container.encode(bmi, forKey: CodingKeys.bmi)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decode(String.self, forKey: .username)
        let genderRawValue = try values.decode(String.self, forKey: .gender)
        gender = Gender(rawValue: genderRawValue) ?? .other
        age = try values.decode(String.self, forKey: .age)
        height = try values.decode(String.self, forKey: .height)
        weight = try values.decode(String.self, forKey: .weight)
        fat = try values.decode(String.self, forKey: .fat)
    }
    
    init() {
        
    }
}

enum Gender: String {
    case male
    case female
    case other
}
