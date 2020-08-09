# Uncomment the next line to define a global platform for your project
platform :ios, '13.6'

target 'Amplify-iOS-Sampler' do
  use_frameworks!

  # Pods for Amplify-iOS-Sampler
  pod 'Amplify', '1.0.6'
#  pod 'Amplify/Tools'

  ## Analytics
  pod 'AmplifyPlugins/AWSPinpointAnalyticsPlugin'
  pod 'AmplifyPlugins/AWSCognitoAuthPlugin'
  
  ## API
  pod 'AmplifyPlugins/AWSAPIPlugin'
  
  ##
  pod 'AWSPredictionsPlugin'
  pod 'CoreMLPredictionsPlugin'

  target 'Amplify-iOS-SamplerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Amplify-iOS-SamplerUITests' do
    # Pods for testing
  end

end
