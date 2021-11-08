//
//  FastingDataManager.swift
//  Fasting
//
//  Created by Apps4World on 2/4/21.
//

import SwiftUI
import Foundation

/// Modal screens presented by the app
enum ModalScreenType: CaseIterable, Identifiable {
    case aboutFasting
    var id: Int { hashValue }
}

/// Main data manager to handle fasting tracking and more
class FastingDataManager: ObservableObject {
    
    /// These properties are dynamic and will invoke UI changes
    @Published var modalScreenType: ModalScreenType?
    @Published var selectedAnswer: QuestionnaireAnswer?
    @Published var fastingModel: FastingModel = FastingModel(type: .fasting)
    @Published var notFastingModel: FastingModel = FastingModel(type: .notFasting)
    @Published var isTracking: Bool = false
    @Published var currentFastingPlan: FastingPlan = .thirteen {
        didSet {
            UserDefaults.standard.setValue(currentFastingPlan.rawValue, forKey: "fastingPlan")
            UserDefaults.standard.synchronize()
        }
    }
    
    @Published var notificationsStatus: Bool = false {
        didSet { savePushNotificationsStatus(notificationsStatus) }
    }
    
    @Published var didShowQuestionnaire: Bool = UserDefaults.standard.bool(forKey: "didShowQuestionnaire") {
        didSet {
            UserDefaults.standard.setValue(didShowQuestionnaire, forKey: "didShowQuestionnaire")
            UserDefaults.standard.synchronize()
        }
    }
    
    @Published var recipeData: [Recipe] = [
        Recipe(image: "icons8-apple-100", title: "Test", description: "testtesttest testtesttest testtesttest testtesttest testtesttest testtesttest", note: "note"),
        Recipe(image: "icons8-apple-100", title: "Test", description: "testtesttest testtesttest testtesttest testtesttest testtesttest testtesttest", note: "note"),
        Recipe(image: "icons8-apple-100", title: "Test", description: "testtesttest testtesttest testtesttest testtesttest testtesttest testtesttest", note: "note"),
        Recipe(image: "icons8-apple-100", title: "Test", description: "testtesttest testtesttest testtesttest testtesttest testtesttest testtesttest", note: "note"),
        Recipe(image: "icons8-apple-100", title: "Test", description: "testtesttest testtesttest testtesttest testtesttest testtesttest testtesttest", note: "note"),
        Recipe(image: "icons8-apple-100", title: "Test", description: "testtesttest testtesttest testtesttest testtesttest testtesttest testtesttest", note: "note"),
        Recipe(image: "icons8-apple-100", title: "Test", description: "testtesttest testtesttest testtesttest testtesttest testtesttest testtesttest", note: "note"),
    ]
    
    @Published var planData: [Plan] = [
        Plan(tag: .beginner, name: "test name", description: "test description description description description description description", detail: "test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail"),
        Plan(tag: .beginner, name: "test name", description: "test description description description description description description", detail: "test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail"),
        Plan(tag: .beginner, name: "test name", description: "test description description description description description description", detail: "test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail"),
        Plan(tag: .beginner, name: "test name", description: "test description description description description description description", detail: "test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail"),
        Plan(tag: .beginner, name: "test name", description: "test description description description description description description", detail: "test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail"),
        Plan(tag: .beginner, name: "test name", description: "test description description description description description description", detail: "test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail test detail"),
    ]
    
    /// Default initializer
    init() {
        /// Get the current activity that is still tracking the time, after the app was closed
        if let activity = activities.first(where: { $0.isTracking }) {
            if activity.type == .fasting {
                fastingModel = activity
                startTrackingActivityTime()
            } else {
                notFastingModel = activity
                notFastingModel.startTimeTracking(block: {
                    self.objectWillChange.send()
                })
            }
        }
        if let plan = UserDefaults.standard.string(forKey: "fastingPlan") {
            currentFastingPlan = FastingPlan(rawValue: plan) ?? .thirteen
        }
        fetchPushNotificationsStatus()
    }
    
    /// Fetch push notifications settings
    private func fetchPushNotificationsStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized { self.notificationsStatus = true }
        }
    }
    
    /// Save the notifications status
    private func savePushNotificationsStatus(_ state: Bool) {
        func requestPushNotificationsPermissions() {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                if settings.authorizationStatus != .authorized {
                    DispatchQueue.main.async {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }
                }
            }
        }
        
        if state {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, _) in
                if !granted { requestPushNotificationsPermissions() }
            }
        } else {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
    }
    
    /// All activities models
    var activities: [FastingModel] {
        var models = [FastingModel]()
        FastingStatus.allCases.forEach({ models.append(FastingModel(type: $0)) })
        return models
    }

    /// Start tracking activity time
    func startTrackingActivityTime() {
        isTracking = true
        notFastingModel.stopTimeTracking()
        setupPushNotificationsReminder()
        fastingModel.startTimeTracking(block: {
            self.objectWillChange.send()
        })
    }
    
    /// Stop tracking activity time
    func stopTrackingActivityTime() {
        isTracking = false
        fastingModel.stopTimeTracking()
        removeNotificationsIfNeeded()
        notFastingModel.startTimeTracking(block: {
            self.objectWillChange.send()
        })
    }
    
    /// Setup push notification daily reminder
    private func setupPushNotificationsReminder() {
        if UserDefaults.standard.bool(forKey: "didScheduleNotification") { return }
        guard let timeFastEnds = Calendar.current.date(byAdding: .hour, value: AppConfig.notificationTestMode ? 0 : Int(currentFastingPlan.rawValue)!, to: Date()) else { return }
        guard let date = Calendar.current.date(byAdding: AppConfig.notificationTestMode ? .second : .minute,
                                               value: AppConfig.notificationTestMode ? 10 : -AppConfig.notificationBeforeFastEnds, to: timeFastEnds) else { return }
        let content = UNMutableNotificationContent()
        content.title = AppConfig.notificationTitle
        content.body = AppConfig.notificationBody
        content.sound = .default
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let errorMessage = error?.localizedDescription {
                if AppConfig.showLogs { print("NOTIFICATION ERROR: \(errorMessage)") }
            } else {
                if AppConfig.showLogs {
                    if let calendarNotificationTrigger = request.trigger as? UNCalendarNotificationTrigger,
                        let nextTriggerDate = calendarNotificationTrigger.nextTriggerDate() {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateStyle = .full
                        dateFormatter.timeStyle = .full
                        print("NOTIFICATION SCHEDULED: \n\(request.content.title)\n\(dateFormatter.string(from: nextTriggerDate))")
                    }
                }
                UserDefaults.standard.setValue(true, forKey: "didScheduleNotification")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    private func removeNotificationsIfNeeded() {
        UserDefaults.standard.setValue(false, forKey: "didScheduleNotification")
        UserDefaults.standard.synchronize()
        UNUserNotificationCenter.current().getPendingNotificationRequests { (request) in
            request.forEach { (request) in
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [request.identifier])
            }
        }
    }
}
