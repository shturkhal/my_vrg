//
//  my_vrgApp.swift
//  my_vrg
//
//  Created by Іван Штурхаль on 08.06.2024.
//

import SwiftUI

@main
struct my_vrgApp: App {
    @StateObject private var favoritesViewModel = FavoritesViewModel()
    @AppStorage("firstLaunch") var firstLaunch = true
    
    var body: some Scene {
        WindowGroup {
            if firstLaunch {
                OnboardingPageView(firstLaunch: $firstLaunch, imageName: "appLogo", title: "Welcome to your\n news app", description: "To add article to your Favorite,\n just swipe article to the left") }
            else {
                ContentView()
                    .environmentObject(favoritesViewModel)
            }
        }
    }
}
