#
# Be sure to run `pod lib lint XYHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XYHelper'
  s.version          = '2.1.0'
  s.summary          = 'The Objective-C utilities you always wish you had.'

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
  
#  s.resource_bundles = {
#    'XYHelper' => ['XYHelper/XYHelper.bundle']
#  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

   s.dependency 'HBDNavigationBar', '~> 1.9.6'
   s.dependency 'FLAnimatedImage', '~> 1.0.16'
   s.dependency 'AFNetworking', '~> 4.0.1'
   
   s.dependency 'YBImageBrowser/Video', '~> 3.0.9'
   s.dependency 'YBImageBrowser', '~> 3.0.9'
   
   s.dependency 'MBProgressHUD', '~> 1.2.0'
   s.dependency 'YYCategories', '~> 1.0.4'
   s.dependency 'YYCache', '~> 1.0.4'
   s.dependency 'Masonry', '~> 1.1.0'
   
   s.dependency 'TZImagePickerController'
   
   s.dependency 'JXPagingView/Pager'
   s.dependency 'JXCategoryView'
   s.dependency 'MJRefresh'
   
   s.dependency 'MJExtension'
   s.dependency 'DZNEmptyDataSet'
   s.dependency 'IQKeyboardManager'
   s.dependency 'ReactiveObjC'
   s.dependency 'BRPickerView'
   s.dependency 'SAMKeychain'
   s.dependency 'SDWebImage'
   s.dependency 'Aspects'
   

end
