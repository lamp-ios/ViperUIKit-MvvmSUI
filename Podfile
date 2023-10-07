# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'iOS-Viper-Architecture' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iOS-Viper-Architecture
  pod 'Alamofire', '~> 4.7'
  pod 'AlamofireObjectMapper', '~> 5.2'
  pod 'AlamofireImage', '~> 3.3'
  pod 'PKHUD', '~> 5.0'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
end
