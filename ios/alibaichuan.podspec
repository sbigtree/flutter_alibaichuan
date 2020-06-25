#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint alibaichuan.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'alibaichuan'
  s.version          = '0.0.1'
  s.summary          = '阿里百川SDK'
  s.description      = <<-DESC
阿里百川SDK
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'
  

#  s.source = { :git => 'http://repo.baichuan-ios.taobao.com/baichuanSDK/AliBCSpecs.git',:tag => s.version}
  s.source = { :git => 'http://repo.baichuan-ios.taobao.com/baichuanSDK/AliBCSpecs.git'}

  s.static_framework = true
  s.dependency  'AlibcTradeSDK', '~>4.0.0.8'
  s.dependency  'AliAuthSDK','~>2.0.0.3'
  s.dependency  'mtopSDK','~>3.0.0.4'
  s.dependency  'securityGuard','~>5.4.173'
  s.dependency  'AliLinkPartnerSDK','~>4.0.0.24'
  s.dependency  'BCUserTrack','~>5.2.0.11-appkeys'
  s.dependency  'UTDID','~>1.1.0.16'
  
#  s.source_files
#  s.public_header_files = 'Classes/Bridging-Header.h'
#  s.prefix_header_file = 'Classes/Bridging-Header.h'

#  s.dependency  'AFNetworking','~>3.0'

  

  
#  s.vendored_frameworks ="AliBaichuanSDK/Frameworks/*.framework"
#  s.resource = "AliBaichuanSDK/Resources/*.bundle"

  
  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
