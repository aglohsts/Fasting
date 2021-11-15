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
    var gender = Gender.unknown
    var age: Int?
    var height: Double?
    var weight: Double?
    var fat: Double?
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case username
        case gender
        case age
        case height
        case weight
        case fat
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(username, forKey: CodingKeys.username)
        try container.encode(gender.rawValue, forKey: CodingKeys.gender)
        try container.encode(age, forKey: CodingKeys.age)
        try container.encode(height, forKey: CodingKeys.height)
        try container.encode(weight, forKey: CodingKeys.weight)
        try container.encode(fat, forKey: CodingKeys.fat)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decode(String.self, forKey: .username)
        let genderRawValue = try values.decode(String.self, forKey: .gender)
        gender = Gender(rawValue: genderRawValue) ?? .unknown
        age = try values.decode(Int.self, forKey: .age)
        height = try values.decode(Double.self, forKey: .height)
        weight = try values.decode(Double.self, forKey: .weight)
        fat = try values.decode(Double.self, forKey: .fat)
    }
    
    init() {
        
    }
}

enum Gender: String {
    case male
    case female
    case unknown
}
