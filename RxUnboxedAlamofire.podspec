#
# Be sure to run `pod lib lint RxUnboxedAlamofire.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxUnboxedAlamofire'
  s.version          = '0.1.0'
  s.summary          = 'The easiest way to download and decode Unboxable objects using RxSwift and Alamofire'
  s.homepage         = 'https://github.com/filipbec/RxUnboxedAlamofire'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Filip Beć' => 'filip.bec@gmail.com' }
  s.source           = { :git => 'https://github.com/filipbec/RxUnboxedAlamofire.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/FilipBec'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.11'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'Sources/**/*'
  
  s.dependency 'UnboxedAlamofire'
  s.dependency 'RxAlamofire'
end
