Pod::Spec.new do |s|
  s.name             = 'adtrace_sdk_flutter'
  s.version          = '1.0.0'
  s.summary          = 'AdTrace Flutter SDK for iOS platform'
  s.description      = <<-DESC
                            AdTrace Flutter SDK for iOS platform.
                            DESC
  s.homepage         = 'http://github.com/adtrace'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'AdTrace' => 'info@adtrace.io','Nasser Amini' => 'namini40@gmail.com' }
  s.source           = { :git => 'git@github.com:adtrace/adtrace_sdk_iOS.git' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  s.dependency 'Adtrace-sdk','2.0.7'

  # Flutter.framework does not contain a i386 slice.
#   s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
