//
//  ViewController+SightCallSDKManagerDelegate.swift
//  VisionSDKTestApp
//
//  Created by Guillaume Laurent on 02/09/2024.
//

import UIKit
import SightcallVision
import LSUniversalSDK

// MARK: - SightCallSDKManagerDelegate
extension ViewController: SightCallSDKManagerDelegate {

    func sdkManagerParentViewController() -> UINavigationController? {
        sdkLayer?.model.controllerDelegate as! UINavigationController?
    }

}
