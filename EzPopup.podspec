Pod::Spec.new do |s|
  s.name             = 'EzPopup'
  s.version          = '1.2.4'
  s.summary          = 'EzPopup will help you to show a popup in the simplest way.'



  s.description      = 'EzPopup will help you to show your custom popup. You just need to provide your view or view controller.'

  s.homepage         = 'https://github.com/huynguyencong/EzPopup'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'huynguyencong' => 'conghuy2012@gmail.com' }
  s.source           = { :git => 'https://github.com/huynguyencong/EzPopup.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'

  s.source_files = 'EzPopup/Classes/**/*'
end
