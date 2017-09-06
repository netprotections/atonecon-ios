AtoneCon iOS SDK
================
The AtoneCon iOS SDK make it easy to perform an Atone payment inside your iOS app.
## A. Requirements

- iOS 8.0+
- Xcode 8.3


## B. Installation

### 1. Use CocoaPods (recommended)
> Embedded frameworks require a minimum deployment target of iOS 8.

### CocoaPods

#### Install CocoaPod
There are two ways to do this
##### Way 1: As a global Ruby gem
[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```
##### Way 2: Per project via bundler
- Step 1: Open a `terminal` window and run this command:

```bash
gem install bundler
```
- Step 2: Specify your dependencies in a Gemfile in your project's root:

```bash
source 'https://rubygems.org'
gem 'cocoapods', '~> 1.2.0'
```
- Step 3: Install all of the required gems from your specified sources:


```bash
bundle install
```


#### Config Podfile
> CocoaPods 1.2+ is required to build AtoneCon 1.0+ 

To integrate AtoneCon framework into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks! # swift project

pod 'AtoneCon', '~> 1.0'
```

Sometimes you may want to use the bleeding edge version of a Pod, a specific revision or your own fork. If this is the case, you can specify that with your pod declaration.

- To use the master branch of the repo:

```
pod ‘AtoneCon’, :git => 'git@github.com:AsianTechInc/AtoneCon-iOS.git'
```
- To use a different branch of the repo:

```
pod ‘AtoneCon’, :git => 'git@github.com:AsianTechInc/AtoneCon-iOS.git', :branch => '...'
```
- To use a tag of the repo:

```
pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :tag => '...'
```
- Or specify a commit:

```
pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :commit => '...'
```

#### Install AtoneCon
Then, run the following command:

```bash
$ [bundle exec] pod install
```

### 2. Manual
- Open up Terminal, access to your top-level project directory

```bash
cd <path-to-Folder-project-dir>
```

- Add AtoneCon as a git submodule by running the following command:

```
$ git submodule add git@github.com:AsianTechInc/AtoneCon-iOS.git
```
- Open the new AtoneCon folder, and drag the `AtoneCon.xcodeproj` into the `Project Navigator` of your application's Xcode project.
> It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `AtoneCon.xcodeproj` in the `Project Navigator` and verify the deployment target matches that of your application target.

- Next, select your application project in the `Project Navigator` (blue project icon) to navigate to the target configuration window and select the application target under the `Targets` heading in the sidebar.

- In the tab bar at the top of that window, open the `General` panel.

- Click on the + button under the `Embedded Binaries` section.

- You will see two different `AtoneCon.xcodeproj` folders each with two different versions of the `AtoneCon.framework` nested inside a Products folder.
>It does not matter which Products folder you choose from, but it does matter whether you choose the top or bottom AtoneCon.framework.

- Select the top `AtoneCon.framework` for iOS.

- The `AtoneCon.framework` is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device. 

## C. Usage

### 1. Configuration

```swift
// You have to configuration options before perform payment
var options = AtoneCon.Options(publicKey: "xxxyyyzzz")
options.environment = .development
let atoneCon = AtoneCon.shared
atoneCon.config(options)
atoneCon.delegate = self // AtoneConDelegate
```

### 2. Perform payment

#### Create new payment

```swift
// These are required properties.

var payment = AtoneCon.Payment(
    amount: 10,
    shopTransactionNo: "",
    checksum: "zzzccccvvvvv" // The checksum is initialized from the shop's private key and payment information
)


/**
The following attributes are not required.
If the attribute has value, it must be passed to the object.
If it hasn't value, it wouldn't be mentioned or would be set to nil.
*/

payment.salesSettled = false // Bool?
payment.descriptionTrans = "備考です。" // String?
```

#### Configure customer

###### Create new customer

```swift
// These are required properties.
var customer = AtoneCon.Customer(name: "接続テスト")

/** 
The following attributes are not required.
If the attribute has value, it must be passed to the object.
If it hasn't value, it wouldn't be mentioned or would be set to nil.
*/

customer.nameKana = "セツゾクテスト" // String?
customer.companyName = "（株）ネットプロテクションズ" // String?
...
...
```

###### Configure customer
```swift
payment.customer = customer
```

#### Configure destination customers ( The attribute are not required )

###### Create destination custumer
```swift
// These are required properties.
var desCustomer = AtoneCon.DesCustomer(
    name: "銀座太郎", 
    zipCode: "123-1234", 
    address: "東京都中央区銀座１－１０ー６　銀座ファーストビル４階"
)

/**						
The following attributes are not required.
If the attribute has value, it must be passed to the object.
If it hasn't value, it wouldn't be mentioned or would be set to nil.
*/

desCustomer.nameKana = "ぎんざたろう" // String?
desCustomer.companyName = "株式会社ネットプロテクションズ" // String?
...
```	

###### Configure destination customers

```swift
payment.desCustomers = [desCustomer]		
```

#### Configure shop items

###### Create items
```swift
// These are required properties.
var item = AtoneCon.Item(
    id: "1", 
    name: "１０円チョコ", 
    price: 10, 
    count: 1
)

/**
The following attributes are not required.
If the attribute has value, it must be passed to the object.
If it hasn't value, it wouldn't be mentioned or would be set to nil.
*/

item.url = "https://atone.be/items/1"
```
###### Configure shop items

```swift
payment.items = [item]
```

### Perform a payment

```swift
AtonePay.performPayment(payment)
```

### 3. Handle payment delegation

```swift
extension YourPaymentController: AtoneConDelegate {
    func atoneCon(atoneCon: AtoneCon, didReceivePaymentEvent event: AtoneCon.PaymentEvent) {
        switch event {
        case .authenticated(let authenToken):
            // save authenToken to use later etc...
        case .cancelled:
            // payment was cancelled
        case .failed(let response):
            // payment process return failure
            /*
            If the properties of the payment are initialized incorrectly, respone will be a object with format as follows
                {
                    "name":ExampleException,
                    "message":"error message"
                    "errors" :[
                        "code": EATN.......,
                        "messages": ["error message 1", "error message 2"]
                        "params": ["param1", "param2"]
                    ]
                }

            If payment failed, respone will be a object with format as follows
                {
                    "id": "tr_aaaaaaa",
                    "authorization_result": 2, // 2: NG
                    "authorization_result_ng_reason":9 // 1: Exceeded the allowed amount or 9: other
                    "subtract_point":0
                }
            
            */
        case .finished(let response):
            // payment finished
            /*
            if payment finished, respone will be a object with format as follows
            {
                "id":"tr_aaaaaaa",
                "authorization_result":1, // 1: OK
                "subtract_point":3
            }
            */
        }
    }
}
```
