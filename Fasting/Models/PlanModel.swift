//
//  PlanModel.swift
//  Fasting
//
//  Created by lohsts on 2021/11/8.
//

import SwiftUI
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
    let content: PlanContent
    let detail: String
    @Published var isFavorite: Bool = false
    @Published var isChosen: Bool = false
    
    init(id: String = UUID().uuidString, tag: PlanLevel, content: PlanContent, detail: String) {
        self.id = id
        self.tag = tag
        self.content = content
        self.detail = detail
    }
    
    var gradient: Gradient {
        switch tag {
        case .beginner:
            return Gradient(colors: [Color(#colorLiteral(red: 0.4847264653, green: 0.4169784902, blue: 0.6716101926, alpha: 1)), Color(#colorLiteral(red: 0.3965855241, green: 0.3398780823, blue: 0.5469947457, alpha: 1))])
        case .intermediate:
            return Gradient(colors: [Color(#colorLiteral(red: 0.9689245233, green: 0.5695010083, blue: 0.494715736, alpha: 1)), Color(#colorLiteral(red: 0.8772187267, green: 0.515599448, blue: 0.4478923771, alpha: 1))])
        case .hard:
            return Gradient(colors: [Color(#colorLiteral(red: 0.2997641731, green: 0.6547199572, blue: 0.6694195755, alpha: 1)), Color(#colorLiteral(red: 0.2570414543, green: 0.5614810586, blue: 0.5711966157, alpha: 1))])
        case .alternateDay:
            return Gradient(colors: [Color(#colorLiteral(red: 0.9674802608, green: 0.7327492438, blue: 0.4523254982, alpha: 1)), Color(#colorLiteral(red: 0.9159417069, green: 0.6937150248, blue: 0.4282297073, alpha: 1))])
        }
    }
    
    var name: String {
        return "\(self.content.fasting) - \(self.content.eating)"
    }
    
    var description: String {
        return "\(self.content.fasting)-hour fasting, \(self.content.eating)-hour eating."
    }
}

class PlanContent {
    let fasting: Int
    let eating: Int
    
    init(fasting: Int, eating: Int) {
        self.fasting = fasting
        self.eating = eating
    }
}

/// Fasting plans
enum FastingPlan: String, CaseIterable, Identifiable {
    case thirteen = "13"
    case sixteen = "16"
    case eighteen = "18"
    case twenty = "20"
    case alternateDay = "36"
    var id: Int { hashValue }
}
