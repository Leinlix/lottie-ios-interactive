#
# Be sure to run `pod lib lint lottie-ios.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'lottie-ios'
  s.version          = '2.5.3'
  s.summary          = 'Used to natively render vector animations exported from After Effects.'

  s.description      = <<-DESC
Lottie is a mobile library for Android and iOS that parses Adobe After Effects animations exported as json with bodymovin and renders the vector animations natively on mobile and through React Native!

For the first time, designers can create and ship beautiful animations without an engineer painstakingly recreating it be hand. Since the animation is backed by JSON they are extremely small in size but can be large in complexity! Animations can be played, resized, looped, sped up, slowed down, and even interactively scrubbed.
                       DESC

  s.homepage         = 'https://github.com/airbnb/lottie-ios'
  s.license          = { :type => 'Apache', :file => 'LICENSE' }
  s.author           = { 'Brandon Withrow' => 'buba447@gmail.com' }
  s.source           = { :git => 'https://github.com/airbnb/lottie-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'

  s.exclude_files = 'lottie-ios/Classes/include/**/*'
  s.source_files = 'lottie-ios/Classes/**/*'
  s.osx.exclude_files = ['lottie-ios/Classes/PublicHeaders/LOTAnimationTransitionController.h',
                         'lottie-ios/Classes/Private/LOTAnimationTransitionController.m',
                          'lottie-ios/Classes/PublicHeaders/LOTCacheProvider.h',
                          'lottie-ios/Classes/Private/LOTCacheProvider.m',
                          'lottie-ios/Classes/PublicHeaders/LOTAnimatedSwitch.h',
                          'lottie-ios/Classes/Private/LOTAnimatedSwitch.m',
                          'lottie-ios/Classes/PublicHeaders/LOTAnimatedControl.h',
                          'lottie-ios/Classes/Private/LOTAnimatedControl.m']
  s.resource_bundles = {'Lottie' => ['Lottie/PrivacyInfo.xcprivacy']}

  s.public_header_files = 'lottie-ios/Classes/PublicHeaders/*.h'
  s.ios.frameworks = 'UIKit'
  s.osx.frameworks = ['AppKit', 'CoreVideo']
  s.module_name = 'Lottie'
  s.header_dir = 'Lottie'
end
