# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://cdn.cocoapods.org/'

use_frameworks!
platform :ios, '14.0'

target 'VisionSDKTestApp' do
  # Pods for VisionSDKTestApp
  pod 'SightCallVisionSDK', '5.5.3'

end

target 'VisionSDKTestAppBroadcast' do
  # Pods for VisionSDKTestApp
  pod 'LSUniversalBroadcastSDK', '5.4.2'

end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
        	end
        end
    end
end

