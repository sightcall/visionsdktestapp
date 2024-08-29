//
//  ViewController+LSUniversalSDKDelegate.swift
//  LSUniversalTest
//
//  Created by dpetrovic on 10/02/2023.
//

import UIKit
import SightcallVision
import LSUniversalSDK

// This enum is for test puropse
private enum ConnectionStatus: Int {
    /** The LSUniversalSDK  is inactive and waiting for function.  **/
    case idle
    /** The LSUniversalSDK is connected as agent.  **/
    case agentConnected
    /** The LSUniversalSDK is registering an agent. **/
    case agentRegistering
    /** The LSUniversalSDK is unregistering as agent. **/
    case agentUnregistering
    /** *  The LSUniversalSDK is connecting. */
    case connecting
    /**  The LSUniversalSDK is connected. Depending on the authentication process, a call is being created. **/
    case active
    /**  A call was started. **/
    case calling
    /** A call is active. **/
    case callActive
    /** The LSUniversalSDK is disconnecting. **/
    case disconnecting
    /** The connection was lost. **/
    case networkLoss
    /** Dummy. **/
    case dummy
}

// MARK: - LSUniversalDelegate
extension ViewController: SightCallSDKManagerDelegate {

    // MARK: Mandatory functions

    func connectionEvent(_ status: lsConnectionStatus_t) {
        // For user friendly print we are casting status to Swift ConnectionStatus enum
        print("VisionSDKTest status:", ConnectionStatus(rawValue: status.rawValue) ?? .dummy)
        switch status {

            // Call status
        case .connecting:
            break
        case .active:
            break
        case .calling:
            break
        case .callActive:
            Task { @MainActor in
                guard let callViewController = self.universal.callViewController else { return }
                self.topViewController = callViewController
                self.present(callViewController, animated: true)
            }
        case .disconnecting:
            break
        case .networkLoss:
            break
        case .idle:
            break

            // Agent status
        case .agentConnected:
            break
        case .agentRegistering:
            break
        case .agentUnregistering:
            break

        @unknown default:
            break
        }
    }
    
    func connectionError(_ error: lsConnectionError_t) {
        switch error {
        case .networkError:
            break
        case .badCredentials:
            break
        case .unknown:
            break
        @unknown default: break
        }
        
    }
    
    func callReport(_ callEnd: LSCallReport) {
        // Call ended. We can dismiss our VC here
        Task { @MainActor in self.topViewController?.dismiss(animated: true) }
        switch callEnd.callEnd {
        case .local:
            break
        case .remote:
            break
        case .eulaRefused:
            break
        case .timeout:
            break
        case .unexpected:
            break
        @unknown default: break
        }
    }
    
    func sdkManagerParentViewController() -> UINavigationController? {
        sdkLayer?.model.controllerDelegate as UINavigationController?
    }


// MARK: Optional functions

    func acdStatusUpdate(_ update: LSACDQueue) {

    }
    
    func acdAcceptedEvent(_ agentUID: String?) {
        
    }
    
    func callSurvey(_ infos: LSSurveyInfos) {
        
    }
    
    func callAgentPoll(_ agentPollAlert: UIAlertController) {
        
    }
    
    func notificationUsecaseAvailable() {
        
    }
    
    func notificationReceived(_ notification: LSNotification) {
        
    }
    
    func guestAcceptedCall(_ userResponse: ((Bool) -> Void)? = nil) {
        
    }
    
    func agentAcceptedCall(_ callURL: String?, userResponse: ((Bool) -> Void)? = nil) {
        
    }
    
    func agentIncomingCallDidTimeout() {
        
    }

    func displayConsent(with description: LSConsentDescription) {
        // Avoid displaying multiple consent requests
        termsOfConsentAlertController?.dismiss(animated: true)

        termsOfConsentAlertController = UIAlertController(title: description.title,
                                                          message: description.message,
                                                          preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: description.cancelLabel,
                                         style: .cancel) { _ in
            description.consent?(false)
        }

        let agreeAction = UIAlertAction(title: description.agreeLabel,
                                        style: .default) { _ in
            description.consent?(true)
        }

        let eulaAction = UIAlertAction(title: description.eulaLabel,
                                       style: .default) { _ in
            guard let eulaURLString = description.eulaURL,
                  let eulaURL = URL(string: eulaURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(eulaURL) {
                DispatchQueue.main.async {
                    UIApplication.shared.open(eulaURL)
                }
            }
        }

        termsOfConsentAlertController?.addAction(cancelAction)
        termsOfConsentAlertController?.addAction(agreeAction)
        termsOfConsentAlertController?.addAction(eulaAction)

        DispatchQueue.main.async {
            self.show(self.termsOfConsentAlertController!, sender: self)
        }
    }

    func featureCommand(_ feature: LSDeeplinkCommand) {
        
    }
    
    func registrationFailure(with status: LSMARegistrationStatus_t) {
        
    }
    
    func showDisplayNameAlert(_ alertController: UIAlertController?) {
        
    }
}
