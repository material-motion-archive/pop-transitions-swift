Pod::Spec.new do |s|
  s.name         = "MaterialMotionPopTransitions"
  s.summary      = "POP Transitions for Material Motion (Swift)"
  s.version      = "1.0.0"
  s.authors      = "The Material Motion Authors"
  s.license      = "Apache 2.0"
  s.homepage     = "https://github.com/material-motion/pop-transitions-swift"
  s.source       = { :git => "https://github.com/material-motion/pop-transitions-swift.git", :tag => "v" + s.version.to_s }
  s.platform     = :ios, "8.0"
  s.requires_arc = true

  s.source_files = "src/*.{swift}", "src/private/*.{swift}"

  s.dependency "pop", "~> 1.0"
  s.dependency "MaterialMotionTransitions", "~> 1.0"
  s.dependency "MaterialMotionPop", "~> 2.0"
end
