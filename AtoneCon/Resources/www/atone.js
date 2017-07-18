
Atone.config({
             pre_token: "",
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
