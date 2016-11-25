Pod::Spec.new do |s|
  s.name             = 'TUCalendar'
  s.version          = '1.2.0'
  s.summary          = 'A short description of TUCalendar.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/petropavel13/TUCalendar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ivan Smolin' => 'ivan.smolin@touchin.ru' }
  s.source           = { :git => 'https://github.com/petropavel13/TUCalendar.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'TUCalendar/TUCalendar/**/*'

  # s.resource_bundles = {
  #   'TUCalendar' => ['TUCalendar/TUCalendar/Resources/**/*.ttf']
  # }

  s.public_header_files = 'TUCalendar/TUCalendar/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'UIColor+Hex', '1.0.1'
end