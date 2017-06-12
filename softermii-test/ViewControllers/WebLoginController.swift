//
//  ViewController.swift
//  softermii-test
//
//  Created by Sergey Mozgovoy on 17/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import UIKit

protocol WebLoginControllerDelegate {
    
    func didFinishLogin()
}

class WebLoginController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    var delegate : WebLoginControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearCacheData()
        startAuthorization()
    }
    
    //MARK: - Actions
    
    @IBAction func cancelTap(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Authorization
    func startAuthorization() {
        
        let responseType = "code"
        
        let redirectURL = Globals.APIParams.redirectURI.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
        
        var authorizationURL = "\(Globals.APIParams.authorizationEndPoint)?"
        authorizationURL += "response_type=\(responseType)&"
        authorizationURL += "client_id=\(Globals.APIParams.instagramClientID)&"
        authorizationURL += "redirect_uri=\(redirectURL)&"
        
        print(authorizationURL)
        
        let request = URLRequest(url: URL(string: authorizationURL)!)
        webView.loadRequest(request)
    }
    
    func requestForAccessToken(_ authorizationCode: String) {
        let parametrs = ["code" : authorizationCode,"client_id":Globals.APIParams.instagramClientID,"client_secret":Globals.APIParams.instagramSecret, "grant_type" : "authorization_code","redirect_uri":Globals.APIParams.redirectURI]
        APIManager.sharedInstance.getAccessTokenWithParams(parameters: parametrs, success: { () in
            self.dismiss(animated: true, completion: {
                self.delegate?.didFinishLogin()
            })
            
        }) { () in
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    //MARK: - WebView Delegate
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("webViewDidStartLoad")

    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("webViewDidFinishLoad")

    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let url = request.url!
        print(url.host!)
        if url.host == "staging.recruit.com" {
            if url.absoluteString.range(of: "code") != nil {
                // Extract the authorization code.
                let urlParts = url.absoluteString.components(separatedBy: "?")
                let code = urlParts[1].components(separatedBy: "=")[1]
                requestForAccessToken(code)
            }
        }
        return true
    }
    //MARK: - Private methods
  
    private func clearCacheData() {
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
    }
}
