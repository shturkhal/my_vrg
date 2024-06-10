//
//  FavoritesViewModel.swift
//  my_vrg
//
//  Created by Іван Штурхаль on 10.06.2024.
//

import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favoriteArticles: [Article] = []
    
    func addToFavorites(article: Article) {
        if !favoriteArticles.contains(where: { $0.id == article.id }) {
            favoriteArticles.append(article)
        }
    }
    
    func removeFromFavorites(article: Article) {
        if let index = favoriteArticles.firstIndex(where: { $0.id == article.id }) {
            favoriteArticles.remove(at: index)
        }
    }
    
    func removeFavorites(at offsets: IndexSet) {
        favoriteArticles.remove(atOffsets: offsets)
    }
}
