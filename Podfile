platform :ios, '12.0'

target 'GitHubLogin' do
  use_frameworks!

  # Pods for GitHubLogin
  pod 'RxSwift'
  pod 'RxCocoa'
  
  # Network
  pod 'Moya'
  pod 'Moya/RxSwift'
  
  # Image Caching
  pod 'Kingfisher'

  target 'GitHubLoginTests' do
    inherit! :search_paths

    # Pods for testing
    pod 'RxBlocking'
    pod 'RxTest'
  end

  target 'GitHubLoginUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.5'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
