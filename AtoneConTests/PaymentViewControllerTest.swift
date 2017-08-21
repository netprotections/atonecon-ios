//
//  PaymentViewControllerTest.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 8/21/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import XCTest
@testable import AtoneCon

class PaymentViewControllerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInit() {
        // When
        let options = AtoneCon.Options(publicKey: "public_key")
        var payment = AtoneCon.Payment(amount: 10, shopTransactionNo: "", checksum: "")
        payment.customer = AtoneCon.Customer(name: "hanh")
        payment.desCustomers = nil
        payment.items = []
        AtoneCon.shared.config(options)
        Session.shared.credential = Session.Credential(value: "tk_abcxyz")
        let paymentController = PaymentViewController(payment: payment)
        let scale = Define.Helper.Ratio.horizontal

        let json = "\nAtone.config({" +
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

        let html = "<!DOCTYPE html>" +
            "<html lang=\"ja\">" +
            "<head>" +
            "<meta charset=\"UTF-8\">" +
            "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">" +
            "<meta name=\"viewport\" content=\"initial-scale=\(scale),maximum-scale=1.0,width=device-width,user-scalable=1\">" +
            "<link rel=\"stylesheet\" href=\"https://www.w3schools.com/w3css/4/w3mobile.css\">" +
            "<script src=\"https://it-auth.a-to-ne.jp/v1/atone.js\">" +
            "</script>" +
            "</head>" +
            "<title>ページタイトル</title>" +
            "<body style=\"background-color:rgba(0, 0, 0, 0.3);\">" +
            "</body>" +
        "</html>"

        // Then
        XCTAssertEqual(paymentController.handlerScript , json)
        XCTAssertEqual(paymentController.atoneHTML, html)

        // When
        paymentController.viewDidLoad()
        XCTAssertNotNil(paymentController.webView)
        XCTAssertNotNil(paymentController.indicator)
        XCTAssertNotNil(paymentController.scriptHandler)
    }

    func testViewDidLayoutSubView() {
        // When
        var payment = AtoneCon.Payment(amount: 10, shopTransactionNo: "", checksum: "")
        payment.customer = AtoneCon.Customer(name: "hanh")
        payment.desCustomers = nil
        payment.items = []
        let paymentController = PaymentViewController(payment: payment)
        paymentController.viewDidLoad()
        paymentController.viewDidLayoutSubviews()

        // Then
        XCTAssertEqual(paymentController.webView.frame, UIScreen.main.bounds)
    }
}
