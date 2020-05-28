source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
inhibit_all_warnings!
use_frameworks!
install! 'cocoapods', :deterministic_uuids => false

workspace 'AtoneCon.xcworkspace'

def shared_pods
    pod 'ObjectMapper', '~> 4.2'
    pod 'SAMKeychain', '~> 1.5'
end

target 'AtoneCon' do
    project 'AtoneCon'
    shared_pods
    target 'AtoneConTests' do
        inherit! :search_paths
        shared_pods
    end
end


target 'AtoneConDemo' do
    project 'AtoneConDemo'
    pod 'SwiftLint', '0.27.0'
    pod 'SwiftUtils', '~> 4.0.1'
    pod 'AtoneCon', :path => './'
    pod 'Toast-Swift', '~> 3.0.0'
end
