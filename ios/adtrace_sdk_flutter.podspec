Pod::Spec.new do |s|
  s.name                  = 'adtrace_sdk_flutter'
  s.version               = '1.5.0'
  s.summary               = 'AdTrace Flutter SDK for iOS platform'
  s.description           = <<-DESC
                                 AdTrace Flutter SDK for iOS platform.
                                 DESC
  s.homepage              = 'http://github.com/adtrace'
  s.license               = { :file => '../LICENSE' }
  s.author                = { 'AdTrace' => 'info@adtrace.io','Nasser Amini' => 'namini40@gmail.com' }
  s.source                = { :git => '.' }
  s.source_files          = 'Classes/**/*'
  s.public_header_files   = 'Classes/**/*.h'
  s.ios.deployment_target = '8.0'

  s.dependency 'Flutter'
  s.dependency 'Adtrace-sdk','2.3.0'
end
