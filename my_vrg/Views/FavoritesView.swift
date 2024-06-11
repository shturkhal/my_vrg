//
//  FavoritesView.swift
//  my_vrg
//
//  Created by Іван Штурхаль on 08.06.2024.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if favoritesViewModel.favoriteArticles.isEmpty {
                    Text("Add your favorite news")
                        .font(.headline)
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(favoritesViewModel.favoriteArticles) { article in
                            NavigationLink(destination: WebView(url: URL(string: article.url)!)) {
                                ArticleRowView(article: .constant(article))
                                    .swipeActions {
                                        Button(action: {
                                            favoritesViewModel.removeFromFavorites(article: article)
                                        }) {
                                            Text("Remove")
                                        }
                                        .tint(.red)
                                    }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Favorites")
        }
    }
}


