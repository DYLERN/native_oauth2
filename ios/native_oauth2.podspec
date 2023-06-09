#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint native_oauth2.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'native_oauth2'
  s.version          = '0.0.2'
  s.summary          = 'A library for performing oauth2 flows using native platform controls'
  s.description      = <<-DESC
A library for performing oauth2 flows using native platform controls
                       DESC
  s.homepage         = 'https://deepred.co.za'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Deep Red Technologies' => 'dylan@deepred.co.za' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
