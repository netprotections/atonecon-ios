
// Need to genarate
var data = {
    "amount": 10,
    "shop_transaction_no": "shop-tran-no-1499762955",
    "sales_settled": false,
    "description_trans": "備考です。",
    "customer": {
        "customer_name": "接続テスト",
        "customer_name_kana": "セツゾクテスト",
        "company_name": "（株）ネットプロテクションズ",
        "department": "セールスグループ",
        "zip_code": "1234567",
        "address": "東京都中央区銀座１－１０ー６　銀座ファーストビル４階",
        "tel": "080-1234-1234",
        "email": "np@netprotections.co.jp",
        "total_purchase_amount": 20000,
        "total_purchase_count": 2
    },
    "dest_customer": {
        "dest_customer_name": "銀座太郎",
        "dest_customer_name_kana": "ぎんざたろう",
        "dest_company_name": "株式会社ネットプロテクションズ",
        "dest_department": "システム部門",
        "dest_zip_code": "123-1234",
        "dest_address": "東京都中央区銀座１－１０ー６　銀座ファーストビル４階",
        "dest_tel": "0312341234"
    },
    "items": [{
              "shop_item_id": "1",
              "item_name": "１０円チョコ",
              "item_price": 10,
              "item_count": 1,
              "item_url": "https://atone.be/items/1"
              }],
    "checksum": "iq4gHR9I8LTszpozjDIaykNjuIsYg+m/pR6JFKggr5Q=",
    "subtract_point": 0,
    "track_token": "bBSUYW68VNXzipvZtFZNJoBR"
}
Atone.config({
             pre_token: "tk_Fj2pd6CMEiFp04zcmTOiBLfm",
             pub_key: "bB2uNvcOP2o8fJzHpWUumA",
             payment: data,
             // 認証が完了したタイミングで呼び出し
             authenticated: function(authentication_token) {
                window.webkit.messageHandlers.authenticated.postMessage(authentication_token);
             },
             // モーダルを閉じたタイミングで呼び出し
             cancelled: function() {
                window.webkit.messageHandlers.cancelled.postMessage('ングで呼び出し');
             },
             // 決済がNGとなった後、ボタンを押してフォームを閉じたタイミングで呼び出し
             failed: function(response) {
                window.webkit.messageHandlers.failed.postMessage(response);
             },
             // 決済がOKとなり自動でフォームが閉じたタイミングで呼び出し
             succeeded: function(response) {
                window.webkit.messageHandlers.succeeded.postMessage(response);
             }
});

function startAtone() {
    Atone.start();
}
