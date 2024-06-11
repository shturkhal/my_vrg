//
//  ArticlesViewModel.swift
//  my_vrg
//
//  Created by Іван Штурхаль on 08.06.2024.
//

import SwiftUI
import Alamofire

class ArticlesViewModel: ObservableObject {
    
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var error: IdentifiableError? = nil
    
    func fetchArticles(from url: String) {
        isLoading = true
        let parameters: Parameters = ["api-key": "09qTKZJci6m9Bl8q20oBinzxCywOJpdC"]
        
        AF.request(url, parameters: parameters).responseDecodable(of: ArticleResponse.self) { response in
            DispatchQueue.main.async {
                self.isLoading = false
                switch response.result {
                case .success(let data):
                    self.articles = data.results
                case .failure(let error):
                    self.error = IdentifiableError(error: error)
                }
            }
        }
    }
}
