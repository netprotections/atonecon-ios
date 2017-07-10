source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
inhibit_all_warnings!
use_frameworks!
install! 'cocoapods', :deterministic_uuids => false

workspace 'AtoneCon.xcworkspace'

def shared_pods
    pod 'ObjectMapper', '~> 2.2'
end

target 'AtoneCon' do
    project 'AtoneCon'
    shared_pods
    target 'AtoneConTests' do
        inherit! :search_paths
        shared_pods
    end
end


target 'Demo' do
    project 'Demo'
    pod 'SwiftLint', '~> 0.16.1'
    pod 'AtoneCon', :path => './'
end
