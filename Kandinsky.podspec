Pod::Spec.new do |s|
  s.name             = "Kandinsky"
  s.version          = "1.0.0"
  s.summary          = "A short description of Kandinsky."
  s.homepage         = "https://github.com/mislavjavor/Kandinsky"
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { "Mislav Javor" => "mislav.javor@outlook.com" }
  s.source           = { git: "https://github.com/mislavjavor/Kandinsky.git", tag: s.version.to_s }
  s.social_media_url = 'https://twitter.com/mislavjavor'
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.ios.source_files = 'Kandinsky/Sources/**/*.{swift}'
  # s.resource_bundles = {
  #   'Kandinsky' => ['Kandinsky/Sources/**/*.xib']
  # }
  # s.ios.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'Eureka', '~> 1.0'
end
