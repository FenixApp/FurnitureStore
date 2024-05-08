//
//  MainView.swift
//  FurnitureStore
//
//  Created by Dmitriy Starozhilov on 06.05.2024.
//

import SwiftUI

/// Главный экран
struct MainView: View {
    
    private struct Constants {
        static let imageUrlStrings = [
            "https://catherineasquithgallery.com/uploads/posts/2021-03/1614645206_91-p-fon-divana-dlya-fotoshopa-108.png",
            "https://vsememy.ru/kartinki/wp-content/uploads/2023/03/1641179913_4-papik-pro-p-divan-risunok-detskii-4.png",
            "https://i.pinimg.com/originals/d2/8f/34/d28f34f7f9d64c4795b60345621f184c.png"
        ]
        static let logoText = "169.ru"
        static let logoImage = "Logo"
        static let getStarted = "Get Started"
        static let haveAcc = "Don't have an account?"
        static let signIn = "Sign in here"
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.appLightGreen, .appGreen], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 100) {
                headView
                getStartedButton
                signInView
                Spacer()
            }
        }
    }

    
    private var headView: some View {
        VStack {
            Spacer()
                .frame(height: 30)
            Text(Constants.logoText)
                .font(.system(size: 40))
                .fontWeight(.heavy)
                .foregroundStyle(.white)
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                ZStack {
                    Image(Constants.logoImage)
                    Rectangle()
                        .fill(.white.opacity(0.0))
                        .overlay {
                            ProgressView()
                        }
                }
            }
            .frame(width: 290, height: 212)
        }
    }
    
    private var getStartedButton: some View {
        Button {
            isShowDetailView = true
        } label: {
            ZStack {
                Color(.white)
                Text(Constants.getStarted)
                    .fontWeight(.bold)
                    .foregroundStyle(.linearGradient(colors: [.appGreen, .appLightGreen], startPoint: .top, endPoint: .bottom))
                    .font(.system(size: 24))
            }
        }
        .frame(width: 300, height: 55)
        .clipShape(RoundedRectangle(cornerRadius: 26))
        .shadow(color: .appGreen, radius: 2, x: 0.0, y: 3.0)
        .fullScreenCover(isPresented: $isShowDetailView, content: {
            DetailView()
        })
    }
    
    private var signInView: some View {
        VStack {
            Text(Constants.haveAcc)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .foregroundStyle(.white)
            Spacer()
                .frame(height: 10)
            Button {
                signUpPresent = true
            } label: {
                Text(Constants.signIn)
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.bottom, -5)
            }
            .fullScreenCover(isPresented: $signUpPresent, content: {
                AuthorizationView()
            })
            Divider()
                .frame(width: 150, height: 1, alignment: .center)
                .padding(.zero)
                .overlay(.white)
        }
    }
    
    private var imageUrl: URL? {
        URL(string: Constants.imageUrlStrings.randomElement() ?? Constants.logoImage)
    }
    
    @State private var signUpPresent = false
    @State private var isShowDetailView = false
}

#Preview {
    MainView()
}
