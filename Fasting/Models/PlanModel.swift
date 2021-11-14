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
    let content: PlanContent
    @Published var isFavorite: Bool = false
    @Published var isChosen: Bool = false
    
    init(id: String = UUID().uuidString, content: PlanContent) {
        self.id = id
        self.content = content
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
    
    var tag: PlanLevel {
        switch content {
        case .fourteen: return .beginner
        case .sixteen: return .beginner
        case .eighteen: return .intermediate
        case .twenty: return .hard
        case .alternateDay: return .alternateDay
        }
    }
    
    var name: String {
        let fasting = Int(self.content.rawValue)!
        let total = content.totalHours
        let eating = total - Int(self.content.rawValue)!
        
        return "\(fasting) - \(eating)"
    }
    
    var description: String {
        let fasting = Int(self.content.rawValue)!
        let total = content.totalHours
        let eating = total - Int(self.content.rawValue)!
        return "\(fasting)-hour fasting, \(eating)-hour eating in \(content.totalHours) hours."
    }
    
    var detail: String {
        return content.detail
    }
}

enum PlanContent: String, CaseIterable, Identifiable {
    case fourteen = "14"
    case sixteen = "16"
    case eighteen = "18"
    case twenty = "20"
    case alternateDay = "36"
    var id: Int { hashValue }
    
    var detail: String {
        switch self {
        case .fourteen:
            return "For 14:10 intermittent fasting, you will fast for 14 hours and have a 10-hour window for eating."
        case .sixteen:
            return "16:8 intermittent fasting means that you fast for 16 hours and eat for 8 hours, with no breakfast. It is recommended to eat two meals between 12:00 and 20:00. "
        case .eighteen:
            return "This type of fasting, which is the main topic of this article, is similar to the 16:8 intermittent fasting, only the difference is that your eating window is smaller, so you have to manage to consume all your calories for 6 hours of your day."
        case .twenty:
            return "This involves a 4-hour eating window and a 20-hour fast. For example, you might eat between 2:00 pm and 6:00 pm every day and fast for the other 20 hours. This would involve eating either one large, lengthy meal or two smaller meals within this period."
        case .alternateDay:
            return "It is as simple as it sounds. You eat your regular diet for a day, then restrict your energy intake the next day."
        }
    }
    
    var totalHours: Int {
        switch self {
        case .alternateDay: return 48
        default: return 24
        }
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
