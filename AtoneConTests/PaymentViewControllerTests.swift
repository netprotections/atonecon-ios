//
//  PaymentViewControllerTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/21/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
@testable import AtoneCon

final class PaymentViewControllerTests: XCTestCase {

    private let options = AtoneCon.Options(publicKey: "public_key")
    private var payment: AtoneCon.Payment!
    private let scale = Define.Helper.Ratio.horizontal
    private var json: String = ""
    private var html: String = ""

    override func setUp() {
        super.setUp()
        AtoneCon.shared.config(options)
        Session.shared.credential = Session.Credential(authToken: "tk_abcxyz")
        payment = AtoneCon.Payment(amount: 10, shopTransactionNo: "", checksum: "")
        payment.customer = AtoneCon.Customer(name: "hanh")
        payment.desCustomers = nil
        payment.items = []
        let urlJson = "https://ct-auth.a-to-ne.jp/v1/atone.js"

        json = "\nAtone.config({" +
            "pre_token: \"tk_abcxyz\"," +
            "pub_key: \"public_key\"," +
            "payment: data," +
            "authenticated: function(authentication_token) { " +
            "window.webkit.messageHandlers.authenticated.postMessage(authentication_token);" +
            "}," +
            "cancelled: function() { " +
            "window.webkit.messageHandlers.cancelled.postMessage(\'ングで呼び出し\');" +
            "}," +
            "failed: function(response) { " +
            "window.webkit.messageHandlers.failed.postMessage(response);" +
            "}," +
            "succeeded: function(response) { " +
            "window.webkit.messageHandlers.succeeded.postMessage(response);" +
            "}," +
            "error: function(name, message, errors) { " +
            "var response = {name: name, message: message, errors: errors};" +
            "window.webkit.messageHandlers.failed.postMessage(response);" +
            "}" +
            "});" +
        "function startAtone() { Atone.start();}\n"

        html = "<!DOCTYPE html>" +
            "<html lang=\"ja\">" +
            "<head>" +
            "<meta charset=\"UTF-8\">" +
            "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">" +
            "<meta name=\"viewport\" content=\"initial-scale=\(scale),maximum-scale=1.0,width=device-width,user-scalable=1\">" +
            "<link rel=\"stylesheet\" href=\"https://www.w3schools.com/w3css/4/w3mobile.css\">" +
            "<script src=\"%@\">" +
            "</script>" +
            "</head>" +
            "<title>ページタイトル</title>" +
            "<body style=\"background-color:rgba(0, 0, 0, 0.3);\">" +
            "</body>" +
        "</html>"
        
        html = String(format: html, urlJson)
    }

    func testLoadViewShouldLoadedUIWhenLoadedPaymentViewController() {
        // When
        XCTAssertNotNil(payment)
        let paymentController = PaymentViewController(payment: payment)
        paymentController.viewDidLoad()

        // Then
        XCTAssertNotNil(paymentController.webView)
        XCTAssertNotNil(paymentController.indicator)
        XCTAssertNotNil(paymentController.scriptHandler)
    }

    func testViewDidLayoutSubViewShouldAutoSizedWKWebViewWhenOrientedDevice() {
        // When
        XCTAssertNotNil(payment)
        let paymentController = PaymentViewController(payment: payment)
        paymentController.viewDidLoad()
        paymentController.viewDidLayoutSubviews()

        // Then
        XCTAssertEqual(paymentController.webView.frame, UIScreen.main.bounds)
    }
}
