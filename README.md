[English Document here](https://github.com/netprotections/atonecon-ios/blob/master/README.EN.md)
================
 決済モジュール導入ライブラリ iOS 
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

<table border=1>
  <body>
    <tr>
      <th>ステータスコード</th><th>タイプ</th><th>エラーコード</th><th>エラーメッセージ</th><th>エラーアイテム</th>
    </tr>
    <tr>
    <th rowspan="52">400</th>
    <th rowspan="52">InvalidRequest</th>
    <td>EATN0301</td><td width="90%">決済認証トークンが指定されていません。</td><td>NP_Token</td>
    </tr>
    <tr>
    <td>EATN0302</td><td>決済認証トークンの形式が不正です。</td><td>NP_Token</td>
    </tr>
    <tr>
    <td>EATN0307</td><td>追跡トークンの形式が不正です。</td><td>track_token</td>
    </tr>
    <tr>
    <td>EATN0309</td><td>SMSを規定回数以上送信しています。明日以降に再度お試しください。</td><td>track_token</td>
    </tr>
    <tr>
    <td>EATN0312</td><td>利用ポイント数がポイント残高を超過しています。</td><td>NP_Token</td>
    </tr>
    <tr>
    <td>EATN0313</td><td>SMSの再送信ができません。</td><td>NP_Token</td>
    </tr>
    <tr>
    <td>EATN0331</td><td>課金額は1以上の7桁以内の半角数値で設定して下さい。</td><td>amount</td>
    </tr>
    <tr>
    <td>EATN0332</td><td>加盟店取引IDは100文字以内の半角英数字記号で設定して下さい。</td><td>shop_transaction_no</td>
    </tr>
    <tr>
    <td>EATN0333</td><td>売上確定はtrueまたはfalseのいずれかを設定して下さい。</td><td>sales_settled</td>
    </tr>
    <tr>
    <td>EATN0334</td><td>加盟店取引備考は改行以外の制御文字を除く255文字以内で設定して下さい。</td><td>description_trans</td>
    </tr>
    <tr>
    <td>EATN0335</td><td>加盟店商品IDは100文字以内の半角英数字記号で設定して下さい。</td><td>shop_item_id</td>
    </tr>
    <tr>
    <td>EATN0336</td><td>商品明細に値が設定されていません。</td><td>items</td>
    </tr>
    <tr>
    <td>EATN0337</td><td>商品明細数は9999以下で設定して下さい。</td><td>items</td>
    </tr>
    <tr>
    <td>EATN0338</td><td>商品名は100文字以内で設定して下さい。</td><td>item_name</td>
    </tr>
    <tr>
    <td>EATN0339</td><td>商品単価は6桁以内の半角数値で設定して下さい。</td><td>item_price</td>
    </tr>
    <tr>
    <td>EATN0340</td><td>個数は5桁以内の半角数値で設定して下さい。</td><td>item_count</td>
    </tr>
    <td>EATN0341</td><td>商品URLは1000文字以内で設定して下さい。</td><td>item_url</td>
    <tr>
    <td>EATN0342</td><td>氏名は100文字以内の全角で設定してください。</td><td>customer_name</td>
    </tr>
    <tr>
    <td>EATN0343</td><td>ひらがな氏名は128文字以内の全角で設定してください。</td><td>customer_name_kana</td>
    </tr>
    <tr>
    <td>EATN0344</td><td>会社名は100文字以内で設定してください。</td><td>company_name</td>
    </tr>
    <tr>
    <td>EATN0345</td><td>部署名は30文字以内で設定してください。</td><td>department</td>
    </tr>
    <tr>
    <td>EATN0346</td><td>郵便番号は半角数字7桁または半角数字3桁+"-"+半角数字4桁で設定してください。</td><td>zip_code</td>
    </tr>
    <tr>
    <td>EATN0347</td><td>住所は255文字以内で設定してください。</td><td>address</td>
    </tr>
    <tr>
    <td>EATN0348</td><td>電話番号は0から始まる半角数字10,11桁または半角数字2,3桁+"-"+半角数字4桁+"-"+半角数字4桁で設定してください。</td><td>tel</td>
    </tr>
    <tr>
    <td>EATN0349</td><td>メールアドレスは255文字以内の正しい形式で設定してください。</td><td>email</td>
    </tr>
    <tr>
    <td>EATN0350</td><td>利用ポイント数は7桁以内の半角数値で設定してください。</td><td>subtract_point</td>
    </tr>
    <tr>
    <td>EATN0351</td><td>不正なチェックサムです。</td><td>checksum</td>
    </tr>
    <tr>
    <td>EATN0352</td><td>HTTPリクエストのContent-Typeにはapplication/jsonを指定して下さい。</td><td>-</td>
    </tr>
    <tr>
    <td>EATN0353</td><td>サービス提供先数は9以下で設定して下さい。</td><td>dest_cusomers</td>
    </tr>
    <tr>
    <td>EATN0354</td><td>姓は50文字以内の全角で設定してください。</td><td>customer_family_name</td>
    </tr>
    <tr>
    <td>EATN0355</td><td>名は50文字以内の全角で設定してください。</td><td>customer_given_name</td>
    </tr>
    <tr>
    <td>EATN0356</td><td>ひらがな姓は64文字以内の全角で設定してください。</td><td>customer_family_name_kana</td>
    </tr>
    <tr>
    <td>EATN0357</td><td>ひらがな名は64文字以内の全角で設定してください。</td><td>customer_given_name_kana</td>
    </tr>
    <tr>
    <td>EATN0358</td><td>携帯電話番号は070,080,090始まりの半角数字10,11桁または半角数字2,3桁+"-"+半角数字4桁+"-"+半角数字4桁で設定してください。</td><td>phone_number</td>
    </tr>
    <tr>
    <td>EATN0359</td><td>生年月日はYYYY-MM-DD形式の日付を設定してください。</td><td>birthday</td>
    </tr>
    <tr>
    <td>EATN0360</td><td>性別は男性:1, 女性:2で設定してください。</td><td>sex_division</td>
    </tr>
    <tr>
    <td>EATN0361</td><td>累計購入回数は0以上の7桁以内の半角数値で設定して下さい。</td><td>total_purchase_count</td>
    </tr>
    <tr>
    <td>EATN0362</td><td>累計購入金額は0以上の8桁以内の半角数値で設定して下さい。</td><td>total_purchase_amount</td>
    </tr>
    <tr>
    <td>EATN0303</td><td>"決済認証トークンは有効ではありません。
→無効化を設定する日付がある revoke date
日付を設定する。
ログインスキップが実行されない"</td><td>NP_Token</td>
    </tr>
    <tr>
    <td>EATN0303</td><td>決済認証トークンは有効ではありません。</td><td>NP_Token</td>
    </tr>
    <tr>
    <td>EATN0306</td><td>認証に失敗しました。</td><td>-</td>
    </tr>
    <tr>
    <td>EATN0360</td><td>有効なサービス利用契約が無いため処理できません。</td><td>NP_Token</td>
    </tr>
    <tr>
    <td>EATN0363</td><td>有効な電話番号が会員に設定されていないため処理できません。</td><td>NP_Token</td>
    </tr>
    <tr>
    <td>EATN0304</td><td>店舗公開可能鍵のデータが存在しません。</td><td>shop_public_key</td>
    </tr>
    <tr>
    <td>EATN0308</td><td>会員追跡のデータが存在しません。</td><td>track_token</td>
    </tr>
    <tr>
    <td>EATN0310</td><td>SMS認証のデータが存在しません。</td><td>sms_token</td>
    </tr>
    <tr>
    <td>EATN0399</td><td>現在サービスを利用できません。恐れ入りますが、時間を空けて再度お試し下さい。</td><td>-</td>
    </tr>
    <tr>
    <td>EATN0398</td><td>不正なリクエストです。</td><td>-</td>
    </tr>
    <tr>
    <td>EATN0397</td><td>HTTPリクエストに含まれるJSONの形式が不正です。</td><td>-</td>
    </tr>
    <tr>
    <td>EATN0396</td><td></td><td>-</td>
    </tr>
    <tr>
    <td>EATN0311</td><td>SMS認証に5回以上失敗しました。明日以降に再度お試しください。</td><td>※現在は使用していない</td>
    </tr>
    <tr>
    <td>EATN0305</td><td>携帯番号のデータが存在しません。</td><td>※現在は使用していない</td>
    </tr>
  </body>
</table>
