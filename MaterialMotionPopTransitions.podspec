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
  s.default_subspec = "lib"

  s.subspec "lib" do |ss|
    ss.source_files = "src/*.{swift}", "src/private/*.{swift}"
  end

  s.subspec "examples" do |ss|
    ss.source_files = "examples/*.{swift}", "examples/supplemental/*.{swift}"
    ss.exclude_files = "examples/TableOfContents.swift"
    ss.resources = "examples/supplemental/*.{xcassets}"
    ss.dependency "MaterialMotionPopTransitions/lib"
  end

  s.subspec "tests" do |ss|
    ss.source_files = "tests/src/*.{swift}", "tests/src/private/*.{swift}"
    ss.dependency "MaterialMotionPopTransitions/lib"
  end

  s.dependency "pop", "~> 1.0"
  s.dependency "MaterialMotionTransitions", "~> 1.0"
  s.dependency "MaterialMotionPop", "~> 2.0"
end
