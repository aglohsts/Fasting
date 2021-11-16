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
//    @Published var selectedAnswer: QuestionnaireAnswer?
    @Published var fastingModel: FastingModel = FastingModel(type: .fasting)
    @Published var notFastingModel: FastingModel = FastingModel(type: .notFasting)
    @Published var isTracking: Bool = false
    @Published var currentFastingPlan: FastingPlan = .thirteen {
        didSet {
            UserDefaults.standard.setValue(currentFastingPlan.rawValue, forKey: "fastingPlan")
            UserDefaults.standard.synchronize()
        }
    }
    
    @Published var currentPlan: Plan = Plan(content: .fourteen) {
        didSet {
            UserDefaults.standard.setValue(currentPlan.content.rawValue, forKey: "currentFastingPlan")
            UserDefaults.standard.synchronize()
        }
    }
    
    @Published var notificationsStatus: Bool = false {
        didSet { savePushNotificationsStatus(notificationsStatus) }
    }
    
    @Published var didShowWelcomePage: Bool = UserDefaults.standard.bool(forKey: "didShowWelcomePage") {
        didSet {
            UserDefaults.standard.setValue(didShowWelcomePage, forKey: "didShowWelcomePage")
            UserDefaults.standard.synchronize()
        }
    }
    
    @Published var recipeData: [Recipe] = [
        Recipe(imageName: "recipe_sabudana_khichdi", title: "Sabudana Khichdi", description: "Sabudana ki khichdi is a delicious dish of tapioca pearls (sago) made with potatoes, peanuts and usually had during Hindu fasting days like Navratri, Ekadashi, mahashivratri. It is also a gluten free recipe. In this recipe post, you will get many tips and suggestions to make the best non-sticky sabudana khichdi. ", note: "Bread & Grains", source: "https://www.vegrecipesofindia.com/navratri-recipes-navratri-fasting-recipes", meal: .lunchOrdinner),
        Recipe(imageName: "recipe_grilled_lemon_salmon", title: "GRILLED LEMON SALMON", description: "Having lemon in the name of the recipe really threw me, but it was fantastic! I served it alongside pineapple rice and fresh green beans, making it a very satisfying meal!", note: "Protein", source: "https://www.food.com/recipe/grilled-lemon-salmon-30469", meal: .lunchOrdinner),
        Recipe(imageName: "recipe_veggie_packed_chessy_chicken_salad", title: "VEGGIE-PACKED CHEESY CHICKEN SALAD", description: "This is so yummy! I cook up a bunch of chicken at the beginning of the week for use in salads and such. That worked great for this recipe! I put it on whole wheat bread. What a healthy, yummy sandwich!", note: "Salad", source: "https://www.food.com/recipe/veggie-packed-cheesy-chicken-salad-reduced-fat-279361", meal: .breakfast),
        Recipe(imageName: "recipe_roasted_cauliflower", title: "CAULIFLOWER POPCORN - ROASTED CAULIFLOWER", description: "Just the idea of being able to eat ‘popcorn’ again, even if it is cauliflower!", note: "Vegetables", source: "https://www.food.com/recipe/cauliflower-popcorn-roasted-cauliflower-115153", meal: .lunchOrdinner),
        Recipe(imageName: "recipe_boiled_eggs", title: "THE EASIEST HARD BOILED EGGS", description: "I wanted to make deviled eggs for thanksgiving dinner but I usually don’t have very good success at boiling the eggs. I tried this method, and it worked out great! I did, however, have one problem - there wasn’t enough room on the platter for all the eggs that turned out wonderfully!", note: "Protein", source: "https://www.food.com/recipe/the-easiest-perfect-hard-boiled-eggs-technique-302972", meal: .breakfast),
    ]
    
    @Published var favoriteRecipeIndex: [Int] = [] {
        didSet {
            UserDefaults.standard.setValue(favoriteRecipeIndex, forKey: "favoriteRecipeIndex")
            UserDefaults.standard.synchronize()
        }
    }
    
    @Published var planData: [Plan] = [
        Plan(content: .fourteen),
        Plan(content: .sixteen),
        Plan(content: .eighteen),
        Plan(content: .twenty),
        Plan(content: .alternateDay),
    ]
    
    @Published var favoritePlanIndex: [Int] = [] {
        didSet {
            UserDefaults.standard.setValue(favoritePlanIndex, forKey: "favoritePlanIndex")
            UserDefaults.standard.synchronize()
        }
    }
    
    /// User Info
    @Published var userInfo: UserInfo = UserInfo()
    
    func saveUserInfo() {
        print("\(userInfo.username) \(userInfo.age) \(userInfo.gender.rawValue)")
//        if let encodedUserInfoData = try? NSKeyedArchiver.archivedData(withRootObject: userInfo) {
        if let encodedUserInfoData = try? JSONEncoder().encode(userInfo) {
            UserDefaults.standard.set(encodedUserInfoData, forKey: "userInfo")
            UserDefaults.standard.synchronize()
        }
    }
    
    func getUserInfo() -> UserInfo {
        if let data = UserDefaults.standard.data(forKey: "userInfo"),
//           let userInfo = NSKeyedUnarchiver.unarchivedObject(ofClass: UserInfo.self, from: data) {
            let userInfo = try? JSONDecoder().decode(UserInfo.self, from: data) {
            return userInfo
        }
        return UserInfo()
    }
    
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
        if let _currentPlan = UserDefaults.standard.string(forKey: "currentFastingPlan") {
            planData.forEach { plan in
                if plan.content.rawValue == _currentPlan {
                    plan.isChosen = true
                }
            }
            currentPlan = Plan(content: PlanContent(rawValue: _currentPlan) ?? .fourteen)
        } else {
            guard let plan = planData.first else { return }
            plan.isChosen = true
            currentPlan = plan
        }
        
        if let favoritePlanIndex = UserDefaults.standard.array(forKey: "favoritePlanIndex") as? [Int] {
            favoritePlanIndex.forEach { index in
                planData[index].isFavorite = true
            }
            self.favoritePlanIndex = favoritePlanIndex
        }
        
        if let favoriteRecipeIndex = UserDefaults.standard.array(forKey: "favoriteRecipeIndex") as? [Int] {
            favoriteRecipeIndex.forEach { index in
                recipeData[index].isFavorite = true
            }
            self.favoriteRecipeIndex = favoriteRecipeIndex
        }
        
        userInfo = getUserInfo()
        
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
    
    // for change plan
    func clearTrackingTime() {
        notFastingModel.stopTimeTracking()
        fastingModel.stopTimeTracking()
    }
    
    /// Setup push notification daily reminder
    private func setupPushNotificationsReminder() {
        if UserDefaults.standard.bool(forKey: "didScheduleNotification") { return }
        guard let timeFastEnds = Calendar.current.date(byAdding: .hour, value: AppConfig.notificationTestMode ? 0 : Int(currentPlan.content.rawValue)!, to: Date()) else { return }
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
