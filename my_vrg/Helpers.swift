//
//  Helpers.swift
//  my_vrg
//
//  Created by Іван Штурхаль on 08.06.2024.
//

import SwiftUI
import WebKit

struct WebView: View {
    
    let url: URL
    var body: some View {
        ZStack {
            WebViewUI(url: url)
        }
    }
}

struct WebViewUI: UIViewRepresentable {
    
    let url: URL

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebViewUI

        init(_ parent: WebViewUI) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         
        }
    }
}

#Preview(body: {
    WebView(url: URL(string: "https://google.com")!)
})
