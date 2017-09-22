//
//  PaymentViewController.swift
//  AtoneCon
//
//  Created by Pham Ngoc Hanh on 6/28/17.
//  Copyright © 2017 AsianTech Inc. All rights reserved.
//

import UIKit
import WebKit
import SAMKeychain

internal protocol PaymentViewControllerDelegate: class {
    func controller(_ controller: PaymentViewController, didReceiveScriptEvent event: ScriptEvent)
}

final internal class PaymentViewController: UIViewController {
    // MARK: - Delegate
    weak var delegate: PaymentViewControllerDelegate?

    // MARK: - Properties
    private var payment: AtoneCon.Payment?
    internal var webView: WKWebView!
    internal var indicator: UIActivityIndicatorView!
    internal var scriptHandler: ScriptHandler!
    fileprivate var closeButton: UIButton!

    func atoneJS() throws -> String {
        // payment script
        guard let paymentJSON = payment?.toJSONString(prettyPrint: true) else {
            let error: [String: Any] = [Define.String.Key.title: Define.String.paymentInfo,
                                        Define.String.Key.message: Define.String.Error.payment]
            throw AtoneConError.payment(error)
        }
        let paymentScript = "var data = " + paymentJSON
        var atoneJSURL = ""
        guard let options = AtoneCon.shared.options else {
            let error: [String: Any] = [Define.String.Key.title: Define.String.options,
                                        Define.String.Key.message: Define.String.Error.options]
            throw AtoneConError.option(error)
        }
        switch options.environment {
        case .development:
            atoneJSURL = "https://ct-auth.a-to-ne.jp/v1/atone.js"
        case .production:
            atoneJSURL = "https://auth.atone.be/v1/atone.js"
        case .staging:
            atoneJSURL = "https://ct-auth.a-to-ne.jp/v1/atone.js"
        }

        // publickKey script
        let publicKey = options.publicKey

        // preToken
        var preToken = ""
        if let accessToken = Session.shared.credential.authToken {
            preToken = accessToken
        }

        // atone script in url
        var contentJSURL = ""
        guard let url = URL(string: atoneJSURL) else {
            let error: [String: Any] = [Define.String.Key.title: Define.String.options,
                                        Define.String.Key.message: Define.String.Error.options]
            throw AtoneConError.option(error)
        }
        do {
            contentJSURL = try String(contentsOf: url)
        } catch {
            let error: [String: Any] = [Define.String.Key.title: Define.String.options,
                                        Define.String.Key.message: Define.String.Error.atoneJSURL]
            throw AtoneConError.option(error)
        }

        let atoneJS = String(format: Define.Scripts.atoneJS, contentJSURL, paymentScript, preToken, publicKey)
        return atoneJS
    }

    func atoneHTML() throws -> String {
        // device scale
        let deviceScale = Define.Helper.Ratio.horizontal
        let atoneHTML = String(format: Define.Scripts.atoneHTML, "\(deviceScale)")
        return atoneHTML
    }

    convenience init(payment: AtoneCon.Payment) {
        self.init()
        self.payment = payment
    }

    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupWebView()
        setupIndicator()
        setupCloseButton()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView?.frame = view.bounds
    }

    // MARK: - Private Functions
    private func setupWebView() {
        do {
            let atoneJS = try self.atoneJS()
            let configuration = WKWebViewConfiguration()
            let userContentController = WKUserContentController()
            let userScript = WKUserScript(source: atoneJS, injectionTime: .atDocumentStart, forMainFrameOnly: false)
            userContentController.addUserScript(userScript)
            configuration.userContentController = userContentController
            webView = WKWebView(frame: view.bounds, configuration: configuration)
            webView.contentMode = .scaleToFill
            webView.autoresizingMask = .flexibleWidth
            let html = try atoneHTML()
            webView.loadHTMLString(html, baseURL: nil)
            webView.backgroundColor = .white
            view.addSubview(webView)
            webView.navigationDelegate = self
            webView.uiDelegate = self
            scriptHandler = ScriptHandler(forWebView: webView)
            scriptHandler.addEvents()
            scriptHandler.delegate = self
        } catch AtoneConError.payment(let error) {
            let event = ScriptEvent.failed(error)
            delegate?.controller(self, didReceiveScriptEvent: event)
        } catch AtoneConError.option(let error) {
            let event = ScriptEvent.failed(error)
            delegate?.controller(self, didReceiveScriptEvent: event)
        } catch {
            let error: [String: Any] = [Define.String.Key.message: Define.String.Error.undefine]
            let event = ScriptEvent.failed(error)
            delegate?.controller(self, didReceiveScriptEvent: event)
        }
    }

    private func setupCloseButton() {
        let width: CGFloat = 36 * Define.Helper.Ratio.horizontal
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let edgeInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 5)
        let frame = CGRect(x: view.frame.width - width - edgeInset.right, y: edgeInset.top + statusBarHeight, width: width, height: width)
        closeButton = UIButton(frame: frame)
        let imageCloseButton = UIImage(named: Define.String.Image.close, in: Bundle.current, compatibleWith: nil)
        closeButton.setBackgroundImage(imageCloseButton, for: .normal)
        closeButton.addTarget(self, action: #selector(closeWebView), for: .touchUpInside)
        view.addSubview(closeButton)
    }

    private func setupIndicator() {
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.center = view.center
        indicator.color = .blue
        view.addSubview(indicator)
    }

    @objc private func closeWebView() {
        let alert = UIAlertController(title: Define.String.quitPayment, message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: Define.String.cancel, style: .cancel, handler: nil)
        let ok = UIAlertAction(title: Define.String.okay, style: .default, handler: { _ in
            AtoneCon.shared.dismiss()
        })
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - WKNavigationDelegate
extension PaymentViewController: WKNavigationDelegate {
    internal func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }
        print(url)
        if url.absoluteString.contains(Define.String.Key.loading) {
            indicator.stopAnimating()
            closeButton.isHidden = true
        }
        decisionHandler(.allow)
    }
    
    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Swift.Void) {
        print("decidePolicyFor navigationResponse")
        decisionHandler(.allow)
    }
    
    
    /*! @abstract Invoked when a main frame navigation starts.
     @param webView The web view invoking the delegate method.
     @param navigation The navigation.
     */
    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation navigation")
    }
    
    
    /*! @abstract Invoked when a server redirect is received for the main
     frame.
     @param webView The web view invoking the delegate method.
     @param navigation The navigation.
     */
    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("didReceiveServerRedirectForProvisionalNavigation navigation")
    }
    
    
    /*! @abstract Invoked when an error occurs while starting to load data for
     the main frame.
     @param webView The web view invoking the delegate method.
     @param navigation The navigation.
     @param error The error that occurred.
     */
    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("didFailProvisionalNavigation navigation:")
    }
    
    
    /*! @abstract Invoked when content starts arriving for the main frame.
     @param webView The web view invoking the delegate method.
     @param navigation The navigation.
     */
    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("didCommit navigation:")
    }
    
    
    /*! @abstract Invoked when a main frame navigation completes.
     @param webView The web view invoking the delegate method.
     @param navigation The navigation.
     */
    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish navigation:")
    }
    
    
    /*! @abstract Invoked when an error occurs during a committed main frame
     navigation.
     @param webView The web view invoking the delegate method.
     @param navigation The navigation.
     @param error The error that occurred.
     */
    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail navigation:")
    }
    
    
    /*! @abstract Invoked when the web view needs to respond to an authentication challenge.
     @param webView The web view that received the authentication challenge.
     @param challenge The authentication challenge.
     @param completionHandler The completion handler you must invoke to respond to the challenge. The
     disposition argument is one of the constants of the enumerated type
     NSURLSessionAuthChallengeDisposition. When disposition is NSURLSessionAuthChallengeUseCredential,
     the credential argument is the credential to use, or nil to indicate continuing without a
     credential.
     @discussion If you do not implement this method, the web view will respond to the authentication challenge with the NSURLSessionAuthChallengeRejectProtectionSpace disposition.
     */
    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
        print("didReceive challenge:")
        completionHandler(.useCredential, nil)
    }
    
    
    /*! @abstract Invoked when the web view's web content process is terminated.
     @param webView The web view whose underlying web content process was terminated.
     */
    @available(iOS 9.0, *)
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("webViewWebContentProcessDidTerminate")
        
    }
}

extension PaymentViewController: WKUIDelegate {
    internal func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        print(navigationAction.request.url)
        if let url = navigationAction.request.url {
            print(url.absoluteString)
            UIApplication.shared.openURL(url)
        }
        return nil
    }
    
    @available(iOS 9.0, *)
    func webViewDidClose(_ webView: WKWebView) {
        print("webViewDidClose")
    }
    
    
    /*! @abstract Displays a JavaScript alert panel.
     @param webView The web view invoking the delegate method.
     @param message The message to display.
     @param frame Information about the frame whose JavaScript initiated this
     call.
     @param completionHandler The completion handler to call after the alert
     panel has been dismissed.
     @discussion For user security, your app should call attention to the fact
     that a specific website controls the content in this panel. A simple forumla
     for identifying the controlling website is frame.request.URL.host.
     The panel should have a single OK button.
     
     If you do not implement this method, the web view will behave as if the user selected the OK button.
     */
    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Swift.Void) {
        print("runJavaScriptAlertPanelWithMessage message")
        completionHandler()
    }
    
    
    /*! @abstract Displays a JavaScript confirm panel.
     @param webView The web view invoking the delegate method.
     @param message The message to display.
     @param frame Information about the frame whose JavaScript initiated this call.
     @param completionHandler The completion handler to call after the confirm
     panel has been dismissed. Pass YES if the user chose OK, NO if the user
     chose Cancel.
     @discussion For user security, your app should call attention to the fact
     that a specific website controls the content in this panel. A simple forumla
     for identifying the controlling website is frame.request.URL.host.
     The panel should have two buttons, such as OK and Cancel.
     
     If you do not implement this method, the web view will behave as if the user selected the Cancel button.
     */
    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Swift.Void) {
        print("runJavaScriptConfirmPanelWithMessage message")
        completionHandler(true)
    }
    
    
    /*! @abstract Displays a JavaScript text input panel.
     @param webView The web view invoking the delegate method.
     @param message The message to display.
     @param defaultText The initial text to display in the text entry field.
     @param frame Information about the frame whose JavaScript initiated this call.
     @param completionHandler The completion handler to call after the text
     input panel has been dismissed. Pass the entered text if the user chose
     OK, otherwise nil.
     @discussion For user security, your app should call attention to the fact
     that a specific website controls the content in this panel. A simple forumla
     for identifying the controlling website is frame.request.URL.host.
     The panel should have two buttons, such as OK and Cancel, and a field in
     which to enter text.
     
     If you do not implement this method, the web view will behave as if the user selected the Cancel button.
     */
    @available(iOS 8.0, *)
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Swift.Void) {
        print("runJavaScriptTextInputPanelWithPrompt prompt")
        completionHandler(nil)
    }
    
    
    /*! @abstract Allows your app to determine whether or not the given element should show a preview.
     @param webView The web view invoking the delegate method.
     @param elementInfo The elementInfo for the element the user has started touching.
     @discussion To disable previews entirely for the given element, return NO. Returning NO will prevent
     webView:previewingViewControllerForElement:defaultActions: and webView:commitPreviewingViewController:
     from being invoked.
     
     This method will only be invoked for elements that have default preview in WebKit, which is
     limited to links. In the future, it could be invoked for additional elements.
     */
    @available(iOS 10.0, *)
    func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool {
        print("shouldPreviewElement elementInfo")
        return false
    }
    
    
    /*! @abstract Allows your app to provide a custom view controller to show when the given element is peeked.
     @param webView The web view invoking the delegate method.
     @param elementInfo The elementInfo for the element the user is peeking.
     @param defaultActions An array of the actions that WebKit would use as previewActionItems for this element by
     default. These actions would be used if allowsLinkPreview is YES but these delegate methods have not been
     implemented, or if this delegate method returns nil.
     @discussion Returning a view controller will result in that view controller being displayed as a peek preview.
     To use the defaultActions, your app is responsible for returning whichever of those actions it wants in your
     view controller's implementation of -previewActionItems.
     
     Returning nil will result in WebKit's default preview behavior. webView:commitPreviewingViewController: will only be invoked
     if a non-nil view controller was returned.
     */
    @available(iOS 10.0, *)
    func webView(_ webView: WKWebView, previewingViewControllerForElement elementInfo: WKPreviewElementInfo, defaultActions previewActions: [WKPreviewActionItem]) -> UIViewController? {
        print("previewingViewControllerForElement elementInfo")
        return nil
    }
    
    
    /*! @abstract Allows your app to pop to the view controller it created.
     @param webView The web view invoking the delegate method.
     @param previewingViewController The view controller that is being popped.
     */
    @available(iOS 10.0, *)
    func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController) {
        print("commitPreviewingViewController previewingViewController")
    }
}

// MARK: - ScriptHandlerDelegate
extension PaymentViewController: ScriptHandlerDelegate {
    func scriptHandler(_ scriptHandler: ScriptHandler, didReceiveScriptEvent event: ScriptEvent) {
        delegate?.controller(self, didReceiveScriptEvent: event)
    }
}
