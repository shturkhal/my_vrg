//
//  MostSharedView.swift
//  my_vrg
//
//  Created by Іван Штурхаль on 08.06.2024.
//

import SwiftUI

struct MostSharedView: View {
    
    @StateObject private var viewModel = ArticlesViewModel()
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    let urlString: String
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.error {
                    Text("Error: \(error.error.localizedDescription)")
                } else {
                    List {
                        ForEach($viewModel.articles) { $article in
                            NavigationLink(destination: WebView(url: URL(string: article.url)!)) {
                                ArticleRowView(article: $article)
                                    .swipeActions {
                                        Button(action: {
                                            if article.isFavorite {
                                                favoritesViewModel.removeFromFavorites(article: article)
                                            } else {
                                                favoritesViewModel.addToFavorites(article: article)
                                            }
                                            article.isFavorite.toggle()
                                        }) {
                                            Text(article.isFavorite ? "Remove" : "Favorite")
                                        }
                                        .tint(article.isFavorite ? .red : .yellow)
                                    }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Most shared")
            .onAppear {
                viewModel.fetchArticles(from: urlString)
            }
        }
    }
}
