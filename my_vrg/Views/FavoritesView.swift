//
//  FavoritesView.swift
//  my_vrg
//
//  Created by Іван Штурхаль on 08.06.2024.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Item 1")
                Text("Item 2")
                Text("Item 3")
            }
            .navigationBarTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesView()
}
