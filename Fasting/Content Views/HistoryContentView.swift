//
//  HistoryContentView.swift
//  Fasting
//
//  Created by Apps4World on 2/9/21.
//

import SwiftUI

/// Week days for the overview
enum WeekDays: String, CaseIterable {
    case Mon, Tue, Wed, Thu, Fri, Sat, Sun
    
    /// Sort the weekdays from today's day to 7 days prior
    static var sortedWeekDays: [WeekDays] {
        let dateFormatter = DateFormatter()
        var last7Days = [WeekDays]()

        for dateIndex in 0..<7 {
            let date = Calendar.current.date(byAdding: .day, value: -dateIndex, to: Date())
            dateFormatter.dateFormat = "EE"
            dateFormatter.locale = Locale(identifier: "US")
            last7Days.append(WeekDays(rawValue: dateFormatter.string(from: date!))!)
        }
        
        return last7Days.reversed()
    }
}

/// Show a history of fasting
struct HistoryContentView: View {
    
    @ObservedObject var manager: FastingDataManager
    
    // MARK: - Main rendering function
    var body: some View {
        HistoryTabView(manager: manager)
    }
}

// MARK: - Render preview UI
struct HistoryContentView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryContentView(manager: FastingDataManager())
    }
}
