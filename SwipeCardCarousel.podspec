Pod::Spec.new do |s|
  s.name             = "SwipeCardCarousel"
  s.version          = "0.0.35"
  s.summary          = "Swipe through a collection of cards stacked in a carousel deck."
  s.description      = "Swipe through a collection of cards stacked in a carousel deck. Useful for swipe card style navigation through views."
  s.homepage         = "https://github.com/syllabix/swipe-card-carousel"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Tom Stoepker" => "tom.stoepker@gmail.com" }
  s.social_media_url = "http://twitter.com/outconsider"
  s.source           = { :git => "https://github.com/syllabix/swipe-card-carousel.git", :tag => s.version.to_s }
  
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }
  s.platforms     = { :ios => "9.1" }
  s.requires_arc = true

  s.source_files     = 'Source/*.{swift,h}'

end

