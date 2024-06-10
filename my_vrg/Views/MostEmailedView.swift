//
//  MostEmailedView.swift
//  my_vrg
//
//  Created by Іван Штурхаль on 08.06.2024.
//

import SwiftUI

struct MostEmailedView: View {
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
                                            favoritesViewModel.addToFavorites(article: article)
                                            article.isFavorite.toggle()
                                        })
                                        {
                                            Text("Favorite")
                                        }
                                        .tint(.yellow)
                                    }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Most Emailed")
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
                    .foregroundColor(article.isFavorite ? .yellow : .primary)
                Text(article.byline)
                    .font(.footnote)
                    .lineLimit(2)
                    .foregroundColor(article.isFavorite ? .yellow : .primary)
            }
        }
    }
}




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
