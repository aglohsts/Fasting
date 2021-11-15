//
//  FastingModel.swift
//  Fasting
//
//  Created by Apps4World on 2/7/21.
//

import SwiftUI
import Foundation

/// The status for fasting
enum FastingStatus: String, CaseIterable {
    case fasting
    case notFasting
}

/// Represents the fasting data
class FastingModel: ObservableObject {
    
    var totalHours: Int = 24
    var secondsTracked: Int = 0
    var type: FastingStatus
    var isTracking: Bool = false
    private var fastingEndTime: String = ""
    private var completion: (() -> Void)?
    
    /// Custom initializer for the model
    init(type: FastingStatus) {
        self.type = type
        if UserDefaults.standard.double(forKey: "lastEntry_\(type.rawValue)") != 0.0 {
            fastingEndTime = UserDefaults.standard.string(forKey: "fastingEndTime") ?? ""
            isTracking = true
        }
    }
    
    /// Get hours, minutes and seconds
    var timeComponents: (h: Int, m: Int, s: Int) {
        (secondsTracked / 3600, (secondsTracked % 3600) / 60, (secondsTracked % 3600) % 60)
    }
    
    /// Seconds progress
    var secondsProgress: Float {
        let totalTime = Float(timeComponents.h * 24 * 60 + timeComponents.m * 60 + timeComponents.s)
        return totalTime / (Float(totalHours) * 24 * 60)
    }
    
    var minutesProgress: Float {
        return Float(timeComponents.m)
    }
    
    /// Get today's tracked time
    var todayTotalTrackedTime: (h: Int, m: Int, s: Int) {
        let totalSeconds = UserDefaults.standard.integer(forKey: todayKey)
        return (totalSeconds / 3600, (totalSeconds % 3600) / 60, (totalSeconds % 3600) % 60)
    }
    
    /// Get today's total tracked seconds
    var todayTotalTrackedSeconds: Int {
        UserDefaults.standard.integer(forKey: todayKey)
    }
    
    /// Formatted last 7 days data
    var formattedLast7Days: String {
        Double(last7DaysTrackedSeconds.reduce(0, +)).asString(style: .abbreviated)
    }
    
    /// Formatted this month  data
    var formattedThisMonth: String {
        Double(thisMonthTrackedSeconds.reduce(0, +)).asString(style: .abbreviated)
    }
    
    /// Formatted fasting end time
    func formattedFastingEndTime(plan: Plan) -> String {
        let fasting = Int(plan.content.rawValue)!
        
        if UserDefaults.standard.double(forKey: "lastEntry_\(type.rawValue)") != 0.0 { // Date().timeIntervalSince1970
            let lastEntryDate = UserDefaults.standard.double(forKey: "lastEntry_\(type.rawValue)")
            let startDateTime = Date(timeIntervalSince1970: lastEntryDate)
            let startDateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: startDateTime)
            
            let endDateTime = Calendar.current.date(byAdding: .hour, value: fasting, to: startDateTime)
            let endDateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: endDateTime!)
            
            return countEndFastingTime(startDateComponents: startDateComponents, endDateComponents: endDateComponents, endDateTime: endDateTime)
        }
        
        let endDateTime = Calendar.current.date(byAdding: .hour, value: fasting, to: Date())
        let endDateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: endDateTime!)
        let currentDateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: Date())

        return countEndFastingTime(startDateComponents: currentDateComponents, endDateComponents: endDateComponents, endDateTime: endDateTime)
    }
    
    private func countEndFastingTime(startDateComponents: DateComponents, endDateComponents: DateComponents, endDateTime: Date?) -> String {
        let dayFastingEnds = (endDateComponents.day ?? 0 > startDateComponents.day ?? 0) ? "tomorrow" : "today"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mma"
        guard let endDateTime = endDateTime else { return dayFastingEnds }
        fastingEndTime = "\(dayFastingEnds) \(dateFormatter.string(from: endDateTime))"
        UserDefaults.standard.setValue(fastingEndTime, forKey: "fastingEndTime")
        UserDefaults.standard.synchronize()
        return fastingEndTime
    }
    
    /// Eating window countdown
    func formattedCountdown(plan: Plan) -> String {
        let eating = Int(plan.content.rawValue)!
        
        let planEatingWindowSeconds = eating * 3600
        let elapsedTime = planEatingWindowSeconds - secondsTracked
        if secondsTracked > planEatingWindowSeconds { return "00:00:00" }
        return String(format: "%02d:%02d:%02d", elapsedTime / 3600, (elapsedTime % 3600) / 60, (elapsedTime % 3600) % 60)
    }
    
    /// Get this last 7 days data
    var last7DaysTrackedSeconds: [Int] {
        let last7Days = datesArray(lastCount: 7)
        var data = [Int]()
        last7Days.forEach({ data.append(UserDefaults.standard.integer(forKey: key(forDate: $0))) })
        return data
    }
    
    /// Get this month's data
    var thisMonthTrackedSeconds: [Int] {
        let thisMonth = datesArray(lastCount: 31)
        var data = [Int]()
        thisMonth.forEach({ data.append(UserDefaults.standard.integer(forKey: key(forDate: $0))) })
        return data
    }
    
    /// Get an array of the dates
    private func datesArray(lastCount: Int) -> [Date] {
        var lastDates = [Date]()
        for dateIndex in 0..<lastCount {
            let date = Calendar.current.date(byAdding: .day, value: -dateIndex, to: Date())
            if lastCount > 7 {
                /// When adding this month's data, make sure to add only dates that belongs to this current month
                if Calendar.current.isDate(date!, equalTo: Date(), toGranularity: .month) {
                    lastDates.append(date!)
                }
            } else {
                lastDates.append(date!)
            }
        }
        return lastDates
    }
    
    /// Key for a given date
    private func key(forDate date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YYYY"
        return "\(dateFormatter.string(from: date))_\(type.rawValue)"
    }
    
    /// Today's data key
    private var todayKey: String {
        key(forDate: Date())
    }
    
    /// Start tracking time
    func startTimeTracking(block: @escaping () -> Void) {
        isTracking = true
        completion = block
        var lastStartEntry = UserDefaults.standard.double(forKey: "lastEntry_\(type.rawValue)")
        if lastStartEntry == 0.0 { lastStartEntry = Date().timeIntervalSince1970 }
        UserDefaults.standard.setValue(lastStartEntry, forKey: "lastEntry_\(type.rawValue)")
        UserDefaults.standard.synchronize()
        updateTimeDifference(lastStartEntry)
    }
    
    /// Stop tracking time
    func stopTimeTracking() {
        isTracking = false
        fastingEndTime = ""
        UserDefaults.standard.setValue(UserDefaults.standard.integer(forKey: todayKey) + secondsTracked, forKey: todayKey)
        UserDefaults.standard.setValue(nil, forKey: "lastEntry_\(type.rawValue)")
        UserDefaults.standard.synchronize()
        secondsTracked = 0
    }
    
    private func updateTimeDifference(_ lastStartEntry: Double) {
        if !isTracking { return }
        self.secondsTracked = Calendar.current.dateComponents([.second], from: Date(timeIntervalSince1970: lastStartEntry), to: Date()).second!
        completion?()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.updateTimeDifference(lastStartEntry)
        }
    }
}

// MARK: - Time formatter helper
extension Double {
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        formatter.unitsStyle = style
        guard let formattedString = formatter.string(from: self) else { return "" }
        return formattedString
    }
}
