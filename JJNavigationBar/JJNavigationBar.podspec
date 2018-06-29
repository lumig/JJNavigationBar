Pod::Spec.new do |s|
  s.name         = "JJNavigationBar"
  s.version      = "1.1.0"
  s.summary      = "自定义导航栏控制器"
  s.homepage     = "https://github.com/lumig/JJNavigationBar"
  s.license      = "MIT"
  s.author       = { "lumig" => "lumic@sina.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/lumig/JJNavigationBar.git", :tag => "#{s.version}" }
  s.source_files  = "JJNavigationBar/JJNavigationBar/JJNavigationBar/**/*.{h,m}"
  s.requires_arc = true
  # s.exclude_files = "Classes/Exclude"
  s.dependency 'Masonry'
  #s.dependency 'YYKit'

end