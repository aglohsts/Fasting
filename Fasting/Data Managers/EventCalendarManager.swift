//
//  EventCalendarManager.swift
//  Fasting
//
//  Created by Yu-chen chih on 2021/11/15.
//

import UIKit
import SwiftUI
import EventKit
import EventKitUI

let eventStore = EKEventStore()

struct EKEventWrapper: UIViewControllerRepresentable {

    typealias UIViewControllerType = EKEventEditViewController

    @Binding var isShowing: Bool
    var eventTitle: String
    var eventLink: String

    var theEvent = EKEvent.init(eventStore: eventStore)

    func makeUIViewController(context: UIViewControllerRepresentableContext<EKEventWrapper>) -> EKEventEditViewController {

        let calendar = EKCalendar.init(for: .event, eventStore: eventStore)

        theEvent.startDate = Date()
        theEvent.endDate = Date()
        theEvent.title = eventTitle
        theEvent.notes = "Go back to Fasting App to see the detail or visit the URL"
        theEvent.url = URL(string: eventLink)
        theEvent.calendar = calendar

        let controller = EKEventEditViewController()
        controller.event = theEvent
        controller.eventStore = eventStore
        controller.editViewDelegate = context.coordinator

        return controller
    }

    func updateUIViewController(_ uiViewController: EKEventWrapper.UIViewControllerType, context: UIViewControllerRepresentableContext<EKEventWrapper>) {
        //
    }


    func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing)
    }

    class Coordinator : NSObject, UINavigationControllerDelegate, EKEventEditViewDelegate {

        @Binding var isShowing: Bool

        init(isShowing: Binding<Bool>) {
            _isShowing = isShowing
        }

        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            switch action {
            case .canceled:
                print("Canceled")
                isShowing = false
            case .saved:
                print("Saved")
                do {
                    try controller.eventStore.save(controller.event!, span: .thisEvent, commit: true)
                }
                catch {
                    print("Problem saving event")
                }
                isShowing = false
            case .deleted:
                print("Deleted")
                isShowing = false
            @unknown default:
                print("I shouldn't be here")
                isShowing = false
            }
        }
    }
}
