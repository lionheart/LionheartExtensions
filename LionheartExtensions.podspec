# vim: ft=ruby

Pod::Spec.new do |s|
  s.name             = "LionheartExtensions"
  s.version          =  "5.1.1"
  s.summary          = "Swift Extensions you probably will need. Definitely."
  s.homepage         = "https://github.com/lionheart/LionheartExtensions"
  s.license          = 'Apache 2.0'
  s.author           = { "Dan Loewenherz" => "dan@lionheartsw.com" }
  s.source           = { :git => "https://github.com/lionheart/LionheartExtensions.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/lionheartsw'
  s.documentation_url = 'https://code.lionheart.software/LionheartExtensions/'

  s.requires_arc = true
  s.ios.deployment_target = '13.6'

  s.default_subspec = 'Core'
  s.swift_version = '5'

  s.subspec 'Core' do |spec|
    spec.source_files = ['Pod/Classes/Core/*', 'Pod/Classes/*.swift']
  end
end
