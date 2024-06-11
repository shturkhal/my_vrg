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
                    VStack {
                        Image("demo")
                            .resizable()
                            .cornerRadius(20)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .shadow(color: .newYellow, radius: 10)
                        Text("Swipe left\n to add your favorite")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                    }
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
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarTitle("Favorites")
        }
    }
}


