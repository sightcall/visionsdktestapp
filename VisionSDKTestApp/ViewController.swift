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

    var sdkLayer: SightCallSDKManager?

    var model: LSApplicationModel {
        sdkLayer!.model
    }

    weak var topViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        sdkLayer = SightCallSDKManager(delegate: self)
        start()
    }

    func start() {
        // Before running the app open desktop agent, start session than copy URL here...
        let urlString = "https://guest.sightcall.com/call/a9ee6cc78cdf1ad544e8767a002dbcfc76959d01?pin=187426"
        let url = URL(string: urlString)
        // Now you can start the call
        sdkLayer?.startSdk(url: url, data: nil, forceReload: false)
    }

    func stop() {
        // Stop call
        sdkLayer?.disconnect()
    }

}

