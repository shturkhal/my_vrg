//
//  MostEmailedView.swift
//  my_vrg
//
//  Created by Іван Штурхаль on 08.06.2024.
//

import SwiftUI

struct MostEmailedView: View {
    
    @StateObject private var viewModel = ArticlesViewModel()
     let urlString: String
     
     var body: some View {
         NavigationView {
             Group {
                 if viewModel.isLoading {
                     ProgressView("Loading...")
                 } else if let error = viewModel.error {
                     Text("Error: \(error.error.localizedDescription)")
                 } else {
                     List(viewModel.articles) { article in
                         NavigationLink(destination: WebView(url: URL(string: article.url)!)) {
                             ArticleRowView(article: article)
                         }
                     }
                 }
             }
             .navigationTitle("Most emailed")
             .onAppear {
                 viewModel.fetchArticles(from: urlString)
             }
         }
     }
 }

#Preview {
    MostEmailedView(urlString: "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json")
}

struct ArticleRowView: View {
    let article: Article
    
    var body: some View {
        HStack {
            if let media = article.media?.first, let metadata = media.media_metadata.first {
                AsyncImage(url: URL(string: metadata.url)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 75, height: 75)
                .cornerRadius(8)
            }
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                Text(article.abstract)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
//                Text(article.byline)
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//                Text(article.published_date)
//                    .font(.caption)
//                    .foregroundColor(.secondary)
            }
        }
    }
}
