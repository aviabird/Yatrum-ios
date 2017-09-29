# Uncomment the next line to define a global platform for your project
platform :ios, '11.0.1'

target 'TravelApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TravelApp
  pod 'RxSwift',     '4.0.0-beta.0'
  pod 'RxCocoa',     '4.0.0-beta.0'
  pod 'Moya/RxSwift', git: 'https://github.com/Moya/Moya.git', branch: '10.0.0-dev'
  pod 'ReSwift', '~> 4.0.0'
  #  pod 'ReSwiftRouter'
  pod 'SwiftDate', '~> 4.4.1'
  pod 'GooglePlaces', '~> 2.4.0'
  pod 'Google/SignIn'
  pod 'Google/Analytics'

  target 'TravelAppTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking', '4.0.0-beta.0'
    pod 'RxTest', '4.0.0-beta.0'
  end

  target 'TravelAppUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end
