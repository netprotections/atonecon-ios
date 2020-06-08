Pod::Spec.new do |s|
# Metadata
s.name         = "AtoneCon"
s.module_name  = "AtoneCon"
s.version      = "0.0.4"
s.summary      = "AtoneCon"
s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
s.description  = <<-DESC
s.swift_versions = ['4.0', '4.2', '5.0']
AtoneCon
DESC

s.homepage     = "https://github.com/netprotections/atonecon-ios"

# License
s.license      = { "type" => "MIT", "file" => "LICENSE" }

# Author Metadata
s.author       = "AsianTech Inc."

# Platform Specifics
s.platform     = :ios, "8.0"

# Source Location
s.source       = { :git => "https://github.com/netprotections/atonecon-ios.git", :tag => "#{s.version}" }

# Source Code
s.source_files = "AtoneCon/Sources/**/*.{swift,strings}"
s.resource_bundles = {'AtoneCon' => ['AtoneCon/Resources/**/*']}

# Project Settings
s.requires_arc = true

# Dependency
s.ios.frameworks = 'Foundation', 'UIKit', 'WebKit'
s.dependency 'ObjectMapper', '~> 4.2'
s.dependency 'SAMKeychain', '~> 1.5'
end
