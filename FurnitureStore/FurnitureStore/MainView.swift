//
//  MainView.swift
//  FurnitureStore
//
//  Created by Dmitriy Starozhilov on 06.05.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
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
        
    }
    
    private var headView: some View {
        VStack {
            Spacer()
                .frame(height: 30)
            Text("169.ru")
                .font(.system(size: 40))
                .fontWeight(.heavy)
                .foregroundStyle(.white)
            Image("Logo")
        }
    }
    
    private var getStartedButton: some View {
        NavigationLink {
            Text("")
        } label: {
            ZStack {
                Color(.white)
                Text("Get Started")
                    .fontWeight(.bold)
                    .foregroundStyle(.linearGradient(colors: [.appGreen, .appLightGreen], startPoint: .top, endPoint: .bottom))
                    .font(.system(size: 24))
            }
        }
        .frame(width: 300, height: 55)
        .clipShape(RoundedRectangle(cornerRadius: 26))
        .shadow(color: .appGreen, radius: 2, x: 0.0, y: 3.0)
    }
    
    private var signInView: some View {
        VStack {
            Text("Don't have an account?")
                .font(.system(size: 16))
                .fontWeight(.bold)
                .foregroundStyle(.white)
            Spacer()
                .frame(height: 10)
            NavigationLink {
                Text("")
            } label: {
                Text("Sign in here")
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.bottom, -5)
            }
            Divider()
                .frame(width: 150, height: 1, alignment: .center)
                .padding(.zero)
                .overlay(.white)
        }
    }
}

#Preview {
    MainView()
}
