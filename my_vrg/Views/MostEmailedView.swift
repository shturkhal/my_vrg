//
//  MostEmailedView.swift
//  my_vrg
//
//  Created by Іван Штурхаль on 08.06.2024.
//

import SwiftUI

struct MostEmailedView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Article 1")
                Text("Article 2")
                Text("Article 3")
            }
            .navigationBarTitle("Most Emailed")
        }
    }
}

#Preview {
    MostEmailedView()
}
