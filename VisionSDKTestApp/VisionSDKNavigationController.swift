//
//  VisionSDKNavigationController.swift
//  VisionSDKTestApp
//
//  Created by Guillaume Laurent on 02/09/2024.
//

import UIKit
import SightcallVision
import ApplicationModel

class VisionSDKNavigationController: UINavigationController, ModelControllerDelegate {

    var sdkLayer: SightCallSDKManager?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
    }
    
    private func animateWithTransition(duringBlock: (() -> Void)?, completionBlock: (() -> Void)?) {
        Task { @MainActor in
            if let transitionCoordinator = self.transitionCoordinator {
                transitionCoordinator.animate { _ in
                    duringBlock?()
                } completion: { _ in
                    completionBlock?()
                }
            } else {
                duringBlock?()
                completionBlock?()
            }
        }
    }

    // MARK: ModelControllerDelegate
    
    func connectionStep(_ state: step_t) {
        NSLog("VisionSDKTest connectionStep state \(state)")

        switch state {
        case .idle:
            break
        case .connecting:
            break
        case .calling:
            break
        case .acdPending:
            break
        case .acdAccepted:
            break
        case .callStart:
            Task { @MainActor in

                // Make callViewController visible
                guard let callViewController = self.sdkLayer?.model.universal.callViewController else {
                    return
                }

                guard topViewController != callViewController else {
                    return
                }

                animateWithTransition {
                } completionBlock: {
                    callViewController.view.backgroundColor = .black
                    self.present(callViewController, animated: true)
                }
            }

        case .callEnd:
            // Report to user that call has ended
            break
        case .survey:
            break
        case .agentRefreshing:
            break
        case .agentRegistering:
            break
        case .agent:
            break
        case .agentUnregistering:
            break
        case .networkLost:
            // Report to user that network connection has been lost
            break
        @unknown default:
            break
        }
    }

    func displayCallPopupAndExecute(_ exe: ((Bool) -> Void)!) {

    }

    func cancelCallPopup() {
        // Show cancel call popup
    }

    func displaySurvey(_ infos: (any LSSurveyInfos)!) {
        NSLog("Survey : \(infos.url ?? "no url")")
    }

    func displayCallSummary(_ callReport: LSCallReport!) {
        NSLog("Call ended - reason : \(callReport.callEnd) - duration : \(callReport.callLength)")
    }

    func redirect(to url: URL!) {
        Task { @MainActor in
            UIApplication.shared.open(url)
        }
    }

    func displayTerms(_ consent: LSConsentDescription!) {
        NSLog("Display terms : \(consent.title ?? "<no consent title>") - \(consent.message ?? "<no message>")")
    }

    func showDisplayNameAlert(_ alertController: UIAlertController!) {
        animateWithTransition(duringBlock: nil) {
            self.present(alertController, animated: true)
        }
    }

    func notificationReceived(_ notification: LSNotification!) {

    }

    func featureCommand(_ feature: LSDeeplinkCommand!) {

    }

    func registrationFailure(with status: LSMARegistrationStatus_t) {

    }

    func displaylAgentPoll(_ agentPollAlert: UIAlertController!) {

    }

}
