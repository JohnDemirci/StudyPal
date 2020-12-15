# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'StudyPal' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Firebase/Analytics'
  pod 'FirebaseCore'
  pod 'FirebaseFirestore'
  pod 'FirebaseMessaging'
  pod 'Firebase/Auth'

  post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      end
   end
end

  # Pods for StudyPal

end
