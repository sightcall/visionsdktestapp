//
//  ViewController.swift
//  VisionSDKTestApp
//
//  Created by Guillaume Laurent on 26/08/2024.
//

import UIKit
import SightcallVision
import ApplicationModel

class ViewController: UIViewController {

    var termsOfConsentAlertController: UIAlertController?

    var sdkLayer: SightCallSDKManager? {
        guard let visionSDKNavigationController = navigationController as? VisionSDKNavigationController else {
            return nil
        }
        return visionSDKNavigationController.sdkLayer
    }

    var model: LSApplicationModel? {
        sdkLayer?.model
    }

    weak var topViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup sdkLayer in VisionSDKNavigationController
        if let visionSDKNavigationController = navigationController as? VisionSDKNavigationController {
            visionSDKNavigationController.sdkLayer = SightCallSDKManager(delegate: self)
            visionSDKNavigationController.sdkLayer?.model.controllerDelegate = visionSDKNavigationController
        }

        start()
    }

    func start() {
        // Before running the app open desktop agent, start session than copy URL here...
//        let urlString = "https://guest.sightcall.com/call/23d16e5d8e6d17475ed0002c5d5049d1bbf269ff?pin=914825"

        // ?debug=true
        let urlString = "https://sght.io/a/Me6aT1SA?m=mneoVWFjMi?debug=true"
        let url = URL(string: urlString)
        // Now you can start the call
        sdkLayer?.startSdk(url: url, data: nil, forceReload: false)
    }

    func stop() {
        // Stop call
        sdkLayer?.disconnect()
    }

}

