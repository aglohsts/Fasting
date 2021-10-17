//
//  SettingsContentView.swift
//  Fasting
//
//  Created by Apps4World on 2/9/21.
//

import SwiftUI
import MessageUI

/// Shows the main settings for the app
struct SettingsContentView: View {
    
    @ObservedObject var manager: FastingDataManager
    
    // MARK: - Main rendering function
    var body: some View {
        SettingsTabView(manager: manager)
    }
}

// MARK: - Render preview UI
struct SettingsContentView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsContentView(manager: FastingDataManager())
    }
}

// MARK: - Mail presenter for SwiftUI
class EmailPresenter: NSObject, MFMailComposeViewControllerDelegate {
    public static let shared = EmailPresenter()
    private override init() { }
    
    func present() {
        if !MFMailComposeViewController.canSendMail() { return }
        let picker = MFMailComposeViewController()
        picker.setSubject("Feedback")
        picker.setToRecipients([AppConfig.feedbackEmail])
        picker.mailComposeDelegate = self
        EmailPresenter.getRootViewController()?.present(picker, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        EmailPresenter.getRootViewController()?.dismiss(animated: true, completion: nil)
    }
    
    static func getRootViewController() -> UIViewController? {
        UIApplication.shared.windows.first?.rootViewController
    }
}

