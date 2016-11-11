Pod::Spec.new do |s|

  s.name         = "SHFSignature"
  s.version      = "1.0.0"
  s.summary      = "SHFSignature it's simple"
#  s.description  = ""
s.homepage     = "http://shfsantolim.com"
  s.screenshots  = "http://imageshack.com/a/img924/8009/7VMsEu.png"
  s.license      = "MIT"
  s.author       = "SHFSantolim"
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/felipesantolim/SHFSignature.git", :tag => "1.0.0" }

  s.source_files  = "SHFSignatureView.swift", "SHFSignatureProtocol.swift"

end
