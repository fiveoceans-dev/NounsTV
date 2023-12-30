//
//  YouTubeWebView.swift
//  Nouns TV
//
//  Created by PAVEL on 2023/10/13.
//

import SwiftUI
import WebKit

struct YouTubeWebView: View {
    let youtubeLink: String

    var body: some View {
        NavigationView {
            WebView(url: youtubeLink)
                .navigationBarTitle("YouTube Video", displayMode: .inline)
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript(
                "var meta = document.createElement('meta'); " +
                "meta.setAttribute('name', 'viewport'); " +
                "meta.setAttribute('content', 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'); " +
                "document.getElementsByTagName('head')[0].appendChild(meta);",
                completionHandler: nil
            )
        }
    }
}

struct YouTubeWebView_Previews: PreviewProvider {
    static var previews: some View {
        YouTubeWebView(youtubeLink: "https://www.youtube.com/watch?v=dticrpal5Zo")
    }
}

