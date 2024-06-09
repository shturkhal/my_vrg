//
//  ContentView.swift
//  my_vrg
//
//  Created by Іван Штурхаль on 08.06.2024.
//

import SwiftUI
import Alamofire

struct ContentView: View {
        
    var body: some View {
        TabView {
            FavoritesView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
            MostEmailedView(urlString: "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json")
                .tabItem {
                    Image(systemName: "envelope")
                    Text("Most Emailed")
                }
            
            MostSharedView(urlString: "https://api.nytimes.com/svc/mostpopular/v2/shared/30.json")
                .tabItem {
                    Image(systemName: "square.and.arrow.up")
                    Text("Most Shared")
                }
            
            MostViewedView(urlString: "https://api.nytimes.com/svc/mostpopular/v2/viewed/30.json")
                .tabItem {
                    Image(systemName: "eye")
                    Text("Most Viewed")
                }
            
           
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
