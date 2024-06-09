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
     
//     var body: some View {
//         NavigationView {
//             Group {
//                 if viewModel.isLoading {
//                     ProgressView("Loading...")
//                 } else if let error = viewModel.error {
//                     Text("Error: \(error.error.localizedDescription)")
//                 } else {
//                     List(viewModel.articles) { article in
//                         NavigationLink(destination: WebView(url: URL(string: article.url)!)) {
//                             ArticleRowView(article: article)
//                         }
//                     }
//                 }
//             }
//             .navigationTitle("most emailed")
//             .onAppear {
//                 viewModel.fetchArticles(from: urlString)
//             }
//         }
//     }
// }
    
    var body: some View {
            NavigationView {
                Group {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    } else if let error = viewModel.error {
                        Text("Error: \(error.error.localizedDescription)")
                    } else {
                        List {
                            ForEach(viewModel.articles) { article in
                                NavigationLink(destination: WebView(url: URL(string: article.url)!)) {
                                    ArticleRowView(article: article)
                                }
                                .swipeActions(edge: .trailing) {
                                    Button(action: {
                                        favoritesViewModel.addToFavorites(article: article)
                                    }) {
                                        Label("Add to Favorites", systemImage: "star")
                                    }
                                    .tint(.yellow)
                                }
                            }
                        }
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
                .cornerRadius(20)
            } else {
                
                    Image(systemName: "text.below.photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 75, height: 75)
                        .foregroundStyle(Color.gray)
//                        .cornerRadius(20)
            }
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                   
//                Text(article.abstract)
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                    .lineLimit(2)
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

//
//class FavoritesViewModel: ObservableObject {
//    @Published var favoriteArticles: [Article] = []
//
//    func addToFavorites(article: Article) {
//        if !favoriteArticles.contains(where: { $0.id == article.id }) {
//            favoriteArticles.append(article)
//        }
//    }
//}

class FavoritesViewModel: ObservableObject {
    @Published var favoriteArticles: [Article] = []

    func addToFavorites(article: Article) {
        if !favoriteArticles.contains(where: { $0.id == article.id }) {
            favoriteArticles.append(article)
        }
    }

    func removeFromFavorites(at offsets: IndexSet) {
        favoriteArticles.remove(atOffsets: offsets)
    }
}
