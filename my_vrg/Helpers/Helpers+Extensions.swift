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

struct ArticleRowView: View {
    
    @Binding var article: Article
    
    var body: some View {
        HStack {
            if let media = article.media?.first, let metadata = media.media_metadata.first {
                AsyncImage(url: URL(string: metadata.url)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 75, height: 75)
                .cornerRadius(20)
            } else {
                
                Image(systemName: "text.below.photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
                    .foregroundStyle(Color.gray)
            }
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.callout)
                    .foregroundColor(article.isFavorite ? .newYellow : .primary)
                Text(article.byline)
                    .fontWeight(.light)
                    .lineLimit(2)
                    .foregroundColor(article.isFavorite ? .newYellow : .gray)
            }
        }
    }
}

extension ArticleEntity {
    func toArticle() -> Article {
        var media: [Media]?
        if let mediaData = self.mediaData {
            media = try? JSONDecoder().decode([Media].self, from: mediaData)
        }

        return Article(
            url: self.url ?? "", title: self.title ?? "",
            abstract: "",
            byline: self.byline ?? "",
            published_date: "",
            media: media
        )
    }

    func fromArticle(_ article: Article) {
        self.title = article.title
        self.url = article.url
        self.byline = article.byline
        if let media = article.media {
            self.mediaData = try? JSONEncoder().encode(media)
        }
    }
}
