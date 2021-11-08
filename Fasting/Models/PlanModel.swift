//
//  PlanModel.swift
//  Fasting
//
//  Created by lohsts on 2021/11/8.
//

import Foundation

enum PlanLevel: String {
    case beginner
    case intermediate
    case hard
    case alternateDay = "Alternate Day Plan"
}

class Plan: ObservableObject, Identifiable {
    let id: String
    let tag: PlanLevel
    let name: String
    let description: String
    let detail: String
    @Published var isFavorite: Bool = false
    
    init(id: String = UUID().uuidString, tag: PlanLevel, name: String, description: String, detail: String) {
        self.id = id
        self.tag = tag
        self.name = name
        self.description = description
        self.detail = detail
    }
}
