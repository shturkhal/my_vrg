//
//  OnboardingPageView.swift
//  my_vrg
//
//  Created by Іван Штурхаль on 11.06.2024.
//

import SwiftUI

struct OnboardingPageView: View {
    
    @Binding var firstLaunch: Bool
    let haptic = UIImpactFeedbackGenerator(style: .heavy)
    @State private var isBouncing = false

    let imageName: String
    let title: String
    let description: String
    
    var body: some View {
        ZStack {
            Color.newYellow
                .ignoresSafeArea()
            VStack(spacing: 20) {
                
                Image(imageName)
                    .resizable()
                    .cornerRadius(20)
                    .aspectRatio(contentMode: .fit)

                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text(description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .foregroundStyle(Color.gray)
                
                Button {
                    firstLaunch = false
                    haptic.impactOccurred()
                } label: {
                    Text("GO")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(10)
                    
                }
                .scaleEffect(isBouncing ? 0.9 : 1.0)
                .onAppear {
                    withAnimation(
                        Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                    ) {
                        isBouncing = true
                    }
                }
                .padding(.vertical)
                .padding(.horizontal)
            }
        }
    }
}

