#
#  Be sure to run `pod spec lint HUPhotoBrowser.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "XyOCR"
  s.version      = "1.0.8"
  s.summary      = "ocr function"
  s.homepage     = "https://github.com/huoxinren/XyOCR"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "huoxinren" => "yy_lx@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/huoxinren/XyOCR.git", :tag => "1.0.8" }
  s.source_files  = "XyOCR/libXyOCR/include/XyzOCR/*.h"
  s.resources = "XyOCR/libXyOCR/include/XyzOCR/*.png", "XyOCR/libXyOCR/include/XyzOCR/*.txt", "XyOCR/libXyOCR/include/XyzOCR/*.xml"
  s.requires_arc = true
  s.frameworks = "CoreVideo", "CoreMedia", "AVFoundation", "AudioToolbox", "ImageIO", "UIKit", "Foundation", "CoreGraphics"




  #s.exclude_files = "Classes/Exclude"

  s.public_header_files = "XyOCR/libXyOCR/include/XyzOCR/*.h"





  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.libraries = "stdc++", "xml2", "iconv.2.4.0"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  s.ios.vendored_libraries = 'XyOCR/libXyOCR/*.a','XyOCR/libXyOCR/include/XyzOCR/*.lib'

  #s.ios.vendored_libraries = 'LTVoiceAssistant/Classes/libBDVoiceRecognitionClient.a','LTVoiceAssistant/Classes/libBDSSpeechSynthesizer.a'

  #s.ios.vendored_frameworks = 'LTVoiceAssistant/Classes/*.framework'

  #s.prefix_header_contents = '#import "AHeader.h"','#import "BHeader.h"'

  #s.prefix_header_file = 'LTVoiceAssistant/Classes/Global/LTSpeech-prefix.pch'

end
