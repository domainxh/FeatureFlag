# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'FeatureFlag' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FeatureFlag
  pod 'Firebase/Core', '~> 7.0.0'
  pod 'Firebase/RemoteConfig', '~> 7.0.0'

  # Remove Xcode 12 warnings
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      end
    end
  end
end
