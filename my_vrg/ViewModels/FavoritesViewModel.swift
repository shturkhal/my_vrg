//
//  FavoritesViewModel.swift
//  my_vrg
//
//  Created by Іван Штурхаль on 10.06.2024.
//

import SwiftUI
import CoreData


class FavoritesViewModel: ObservableObject {
    @Published var favoriteArticles: [Article] = []
    let haptic = UIImpactFeedbackGenerator(style: .heavy)
    
    private var context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataManager.shared.context) {
        self.context = context
        fetchFavorites()
    }

    func addToFavorites(article: Article) {
        if !favoriteArticles.contains(where: { $0.url == article.url }) {
            favoriteArticles.append(article)
            saveArticle(article)
            haptic.impactOccurred()
        }
    }

    func removeFromFavorites(article: Article) {
        if let index = favoriteArticles.firstIndex(where: { $0.url == article.url }) {
            favoriteArticles.remove(at: index)
            deleteArticle(article)
            haptic.impactOccurred()
        }
    }

    private func fetchFavorites() {
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        do {
            let articleEntities = try context.fetch(request)
            favoriteArticles = articleEntities.map { $0.toArticle() }
        } catch {
            print("Failed to fetch favorite articles: \(error)")
        }
    }

    private func saveArticle(_ article: Article) {
        let entity = ArticleEntity(context: context)
        entity.fromArticle(article)
        saveContext()
    }

    private func deleteArticle(_ article: Article) {
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", article.url as CVarArg)

        do {
            let entities = try context.fetch(request)
            if let entity = entities.first {
                context.delete(entity)
                saveContext()
            }
        } catch {
            print("Failed to delete article: \(error)")
        }
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
