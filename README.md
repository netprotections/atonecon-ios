[English Document here](https://github.com/netprotections/atonecon-ios/blob/master/README.EN.md)
================
 atone決済モジュール導入ライブラリ（iOS） 
================

## A. 要件

- iOS 8.0+
- Xcode 8.3


## B. インストール

### CocoaPodsを使用
> 組み込みフレームワークには、最小でiOS 8のデプロイメントターゲットが必要

### CocoaPods

#### CocoaPodのインストール
2通りの方法がある。
##### 方法 1: global Ruby gemとしてインストール
[CocoaPods](http://cocoapods.org)はCocoaプロジェクトの依存関係マネージャである。次のコマンドでインストールできる:

```bash
gem install cocoapods
```
##### 方法 2: バンドルによりプロジェクトごとにインストール
- Step 1: `terminal` ウィンドウを開き下記のコマンドを実行：

```bash
gem install bundler
```
- Step 2: プロジェクトのルートにあるGemfileに依存関係を指定:

```bash
source 'https://rubygems.org'
gem 'cocoapods', '~> 1.2.0'
```
- Step 3: 指定したソースから必要なすべてのgemをインストール:


```bash
bundle install
```


#### Podfileのコンフィグ
> AtoneCon 1.0+をビルドするには、CocoaPods 1.2+が必要 


CocoaPodsを使ってXcodeプロジェクトにAtoneConフレームワークを統合するには、 `Podfile`で指定する:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks! # swift project

pod 'AtoneCon', '~> 1.0'
```

場合によっては、Pod、特定のリビジョン、または自分のフォークの最新バージョンを使用することができる。この場合、 pod declarationで指定することができる。

>注：AtoneConライブラリリポジトリのリンクで以下のコマンドを変更する必要がある。


- レポジトリの `master` ブランチを使用する:

```bash
pod 'AtoneCon', :git => 'git@github.com:netprotections/atonecon-ios.git'
```

- `master` 以外のブランチを使用する:

```bash
pod 'AtoneCon', :git => 'git@github.com:netprotections/atonecon-ios.git', :branch => '...'
```

- レポジトリのタグを使用する:

```bash
pod 'AtoneCon', :git => 'git@github.com:netprotections/atonecon-ios.git', :tag => '...'
```

- もしくは、コミットを指定:

```bash
pod 'AtoneCon', :git => 'git@github.com:netprotections/atonecon-ios.git', :commit => '...'
```

#### AtoneConをインストール
以下のコマンドを実行:

```bash
[bundle exec] pod install
``` 

## C. 使用方法

### 1. コンフィグレーション

```swift
// 支払いを実行する前に設定オプションを用意する必要がある
var options = AtoneCon.Options(publicKey: "xxxyyyzzz")
options.environment = .development
let atoneCon = AtoneCon.shared
atoneCon.config(options)
atoneCon.delegate = self // AtoneConDelegate
```

### 2. 決済の実行

#### 新規決済の作成

```swift
// 要素必須

var payment = AtoneCon.Payment(
    amount: 10,
    shopTransactionNo: "",
    checksum: "zzzccccvvvvv" // チェックサムは、店舗の秘密鍵と支払い情報から初期化される


/**
下記は要素必須ではない項目。 ただし、値がある場合はその値をパラメータに必ず設定しなければならない。
*/

payment.salesSettled = false // Bool?
payment.descriptionTrans = "備考です。" // String?
```

#### 購入者のコンフィグ

###### 購入者の新規作成

```swift
// 要素必須
var customer = AtoneCon.Customer(name: "接続テスト")

/** 
下記は要素必須ではない項目。 ただし、値がある場合はその値をパラメータに必ず設定しなければならない。
*/

customer.nameKana = "セツゾクテスト" // String?
customer.companyName = "（株）ネットプロテクションズ" // String?
...
...
```

###### 購入者のコンフィグ

```swift
payment.customer = customer
```

#### サービス提供先(配送先) のコンフィグ( attributeは必須ではない )

###### サービス提供先(配送先) の新規作成
```swift
// 要素必須
var desCustomer = AtoneCon.DesCustomer(
    name: "銀座太郎", 
    zipCode: "123-1234", 
    address: "東京都中央区銀座１－１０ー６　銀座ファーストビル４階"
)

/**
下記は要素必須ではない項目。 ただし、値がある場合はその値をパラメータに必ず設定しなければならない。
*/

desCustomer.nameKana = "ぎんざたろう" // String?
desCustomer.companyName = "株式会社ネットプロテクションズ" // String?
...
```

###### サービス提供先(配送先) のコンフィグ

```swift
payment.desCustomers = [desCustomer]
```

#### 商品明細のコンフィグ

###### 商品明細の新規作成
```swift
// 要素必須
var item = AtoneCon.Item(
    id: "1", 
    name: "１０円チョコ", 
    price: 10, 
    count: 1
)

/**
下記は要素必須ではない項目。 ただし、値がある場合はその値をパラメータに必ず設定しなければならない。
*/

item.url = "https://atone.be/items/1"
```
###### 商品明細のコンフィグ

```swift
payment.items = [item]
```

### 決済の実行

```swift
AtoneCon.shared.performPayment(payment)
```

### 3. 決済のデリゲート処理

```swift
extension YourPaymentController: AtoneConDelegate {
    func atoneCon(atoneCon: AtoneCon, didReceivePaymentEvent event: AtoneCon.PaymentEvent) {
        switch event {
        case .authenticated(let authenToken):
            // authenTokenを保存して後で使用する etc...
        case .cancelled:
            // 決済のキャンセル
        case .failed(let response):
            //　決済プロセスの失敗
            /*　決済のプロパティが正しく初期化されていない場合、responeは次のような形式のオブジェクトになる
                {
                    "name":ExampleException,
                    "message":"error message"
                    "errors" :[
                        "code": EATN.......,
                        "messages": ["error message 1", "error message 2"]
                        "params": ["param1", "param2"]
                    ]
                }

            決済が失敗した場合、responeは次のような形式のオブジェクトになる
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
            決済が完了すると、responeは次のような形式のオブジェクトになる
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


## D. エラー
-----

別紙「atone導入マニュアル」に記載
