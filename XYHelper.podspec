#
# Be sure to run `pod lib lint XYHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XYHelper'
  s.version          = '1.0.3'
  s.summary          = '挤虚体验几番钟, 雷, 揍会干我一样, 爱象节款XYHelper.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/spikeroog/XYHelper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'spikeroog' => 'xiao.yuan@higo.live' }
  s.source           = { :git => 'https://github.com/spikeroog/XYHelper.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'XYHelper/Classes/**/*.{h,m}'
  
  # s.resource_bundles = {
  #   'XYHelper' => ['XYHelper/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'AFNetworking', '~> 4.0'
   s.dependency 'HBDNavigationBar', '~> 1.7.7'
   s.dependency 'SDWebImage', '~> 5.9.0'
   s.dependency 'MBProgressHUD', '~> 1.2.0'
   s.dependency 'YYCache', '~> 1.0.4'
   s.dependency 'YYCategories', '~> 1.0.4'
   s.dependency 'TZImagePickerController', '~> 3.4.2'
   s.dependency 'FLAnimatedImage', '~> 1.0.2'
   s.dependency 'YBImageBrowser', '~> 3.0.9'
   s.dependency 'YBImageBrowser/Video', '~> 3.0.9'
   s.dependency 'Aspects'
   s.dependency 'ReactiveObjC'
   s.dependency 'Masonry'
   
   

end
