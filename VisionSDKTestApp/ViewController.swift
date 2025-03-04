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
    }

    @IBAction func goButtonTouched(_ sender: Any) {
        if let urlString = urlTextField.text,
           let url = URL(string: urlString) {
            sdkLayer?.startSdk(url: url, data: nil, forceReload: false)
        }
    }
}

