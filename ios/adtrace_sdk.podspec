#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'adtrace_sdk'
  s.version          = '0.1.3'
  s.summary          = 'This is the Flutter SDK of AdTrace. You can read more about AdTrace at adtrace.io.'
  s.description      = <<-DESC
This is the Flutter SDK of AdTrace. You can read more about AdTrace at adtrace.io.
                       DESC
  s.homepage         = 'http://adtrace.io'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Aref Hosseini' => 'info@adtrace.io' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'Adtrace', '~> 1.0.1'

  s.ios.deployment_target = '8.0'
end

