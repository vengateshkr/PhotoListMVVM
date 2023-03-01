deployment_target = '13.0'
platform :ios, deployment_target

inhibit_all_warnings!

target 'PhotoList' do
  # Comment the next line if you don't want to use dynamic frameworks
  # use_frameworks!
  pod 'SDWebImage', :modular_headers => true
  pod 'Swinject', '2.8.3'
  # Pods for PhotoList

  target 'PhotoListTests' do
    inherit! :search_paths
    pod 'Quick'
    pod 'Nimble'
  end

  target 'PhotoListUITests' do
    # Pods for testing
    pod 'Nimble'
  end
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
      end
    end
end
