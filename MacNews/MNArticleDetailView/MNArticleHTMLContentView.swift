//
//  MNArticleHTMLContentView.swift
//  MacNews
//
//  Created by Anan Suliman on 06/05/2021.
//

import SwiftUI
import WebKit

struct MNArticleHTMLContentView : UIViewRepresentable {
   
    
    var articleHTMLBody: String
    
    func makeUIView(context: Context) -> WKWebView  {
        
        // Add scripts to for screen adoption
        let viewportScriptString = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width, shrink-to-fit=YES'); meta.setAttribute('initial-scale', '1.0'); meta.setAttribute('maximum-scale', '1.0'); meta.setAttribute('minimum-scale', '1.0'); meta.setAttribute('user-scalable', 'no'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let viewportScript = WKUserScript(source: viewportScriptString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let controller = WKUserContentController()

        controller.addUserScript(viewportScript)
              

        //Initialize a configuration and set controller
        let config = WKWebViewConfiguration()
        config.userContentController = controller
        
        let webView =  WKWebView(frame: CGRect(x: 0, y: 0, width: 0, height: 20000), configuration: config)
        webView.scrollView.isScrollEnabled = false               // Make sure our view is interactable
        webView.allowsBackForwardNavigationGestures = false   // Disable swiping to navigate
        webView.contentMode = .scaleAspectFill                    // Scale the page to fill the web view
        webView.scrollView.subviews.forEach { $0.isUserInteractionEnabled = false }
        webView.backgroundColor = UIColor.clear

        
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.loadHTMLString(articleHTMLBody, baseURL:  nil)
    }

}


