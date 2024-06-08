//
//  MostViewedView.swift
//  my_vrg
//
//  Created by Іван Штурхаль on 08.06.2024.
//

import SwiftUI

struct MostViewedView: View {

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
             .navigationTitle("Most viewed")
             .onAppear {
                 viewModel.fetchArticles(from: urlString)
             }
         }
     }
 }
