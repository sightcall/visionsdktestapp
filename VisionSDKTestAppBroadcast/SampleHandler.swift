//
//  SampleHandler.swift
//  VisionBroadcastTestApp
//
//  Created by Guillaume Laurent on 22/10/2024.
//

/**
 How to setup screencast in your app :

 - create a Broadcast Upload Extension target
 - add AppGroup capability and set a common App Group to the targets for your app and the broadcast extension
 - add a key named LSAppGroupScreenRecording to app Info.plist, and set to that App Group name
 - copy code of SampleHandler below, change the appGroupID argument to your own 
 */

import ReplayKit
import LSUniversalBroadcastSDK
class SampleHandler: RPBroadcastSampleHandler {

    var ubsdk: LSUniversalBroadcast!

    override init() {
        super.init()
        ubsdk = LSUniversalBroadcast(appGroupID: "group.com.sightcall.visionsdktest-broadcast", andHandler: self)
    }

    override func broadcastStarted(withSetupInfo setupInfo: [String : NSObject]?) {
        // User has requested to start the broadcast. Setup info from the UI extension can be supplied but optional.
        ubsdk.start()
    }

    override func broadcastPaused() {
        // User has requested to pause the broadcast. Samples will stop being delivered.
    }

    override func broadcastResumed() {
        // User has requested to resume the broadcast. Samples delivery will resume.
    }

    override func broadcastFinished() {
        // User has requested to finish the broadcast.
        ubsdk.stop()
    }

    override func processSampleBuffer(_ sampleBuffer: CMSampleBuffer, with sampleBufferType: RPSampleBufferType) {
        switch sampleBufferType {
        case RPSampleBufferType.video:
            ubsdk.sendFrame(sampleBuffer)
            break
        case RPSampleBufferType.audioApp:
            // Handle audio sample buffer for app audio
            break
        case RPSampleBufferType.audioMic:
            // Handle audio sample buffer for mic audio
            break
        @unknown default:
            // Handle other sample buffer types
            fatalError("Unknown type of sample buffer")
        }
    }
}
