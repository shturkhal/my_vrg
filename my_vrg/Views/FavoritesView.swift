//
//  FavoritesView.swift
//  my_vrg
//
//  Created by Іван Штурхаль on 08.06.2024.
//

import SwiftUI

//struct FavoritesView: View {
//    var body: some View {
//        NavigationView {
//           Text("Add your favorite news")
//            .navigationBarTitle("favorites")
//        }
//    }
//}

//struct FavoritesView: View {
//    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
//    
//    var body: some View {
//        NavigationView {
//            Group {
//                if favoritesViewModel.favoriteArticles.isEmpty {
//                    Text("Add your favorite news")
//                        .font(.headline)
//                        .foregroundColor(.gray)
//                } else {
//                    List {
//                        ForEach(favoritesViewModel.favoriteArticles) { article in
//                            NavigationLink(destination: WebView(url: URL(string: article.url)!)) {
//                                ArticleRowView(article: article)
//                            }
//                        }
//                    }
//                }
//            }
//            .navigationBarTitle("Favorites")
//        }
//    }
//}


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
                                ArticleRowView(article: article)
                            }
                        }
                        .onDelete(perform: removeArticles)
                    }
                }
            }
            .navigationBarTitle("Favorites")
        }
    }
    
    private func removeArticles(at offsets: IndexSet) {
        favoritesViewModel.removeFromFavorites(at: offsets)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(FavoritesViewModel())
    }
}

#Preview {
    FavoritesView()
}
