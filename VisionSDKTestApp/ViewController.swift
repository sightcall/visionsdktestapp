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

    @IBOutlet weak var urlTextField: UITextField!



    var termsOfConsentAlertController: UIAlertController?

    var sdkLayer: SightCallSDKManager? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate.sdkLayer
    }

    var model: LSApplicationModel? {
        sdkLayer?.model
    }

    weak var topViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup sdkLayer
        sdkLayer?.delegate = self // This is required or your app will crash
        
        if let visionSDKNavigationController = navigationController as? VisionSDKNavigationController {
            sdkLayer?.model.controllerDelegate = visionSDKNavigationController
        }

//        start()
    }

    func start() {
        // Before running the app open desktop agent, start session than copy URL here...
//        let urlString = "https://guest.sightcall.com/call/23d16e5d8e6d17475ed0002c5d5049d1bbf269ff?pin=914825"

        // ?debug=true
        let urlString = "https://sght.io/a/3o7Si1DK?m=mbgzGqThY4"
        let url = URL(string: urlString)
        // Now you can start the call
        sdkLayer?.startSdk(url: url, data: nil, forceReload: false)
    }

    func stop() {
        // Stop call
        sdkLayer?.disconnect()
    }

    @IBAction func goButtonTouched(_ sender: Any) {
        if let urlString = urlTextField.text,
           let url = URL(string: urlString) {
            sdkLayer?.startSdk(url: url, data: nil, forceReload: false)
        }
    }
}

