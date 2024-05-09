//
//  ProfileView.swift
//  FurnitureStore
//
//  Created by Dmitriy Starozhilov on 09.05.2024.
//

import SwiftUI

/// Раздел Профиль
struct ProfileView: View {
    
    private enum Constants {
        static let yourName = "Your Name"
        static let city = "Sity"
    }
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                LinearGradient(colors: [.appLightGreen, .appGreen], startPoint: .leading, endPoint: .trailing)
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .ignoresSafeArea()
                userImageView
                    .padding()
                userInfoView
                descriptionUserView
                Spacer()
            }
        }
    }
    
    private var userImageView: some View {
        ZStack {
            Circle()
                .frame(width: 150, height: 150, alignment: .center)
                .foregroundStyle(.appBeige)
            Image(.imageAccount)
        }
    }
    
    private var userInfoView: some View {
        VStack(spacing: 0) {
            Text(Constants.yourName)
                .font(.system(size: 24))
                .fontWeight(.bold)
                .foregroundStyle(.appGreen)
            HStack {
                Image(.location)
                Text(Constants.city)
                    .font(.system(size: 20))
                    .foregroundStyle(.appGreen)
            }
        }
    }
    
    private var descriptionUserView: some View {
        List(profileViewModel.listInfoProfile) { item in
            makeDescriptionCellView(item)
        }
        .listStyle(.plain)
    }
    
    private func makeDescriptionCellView(_ item: Profile) -> some View {
        ZStack(alignment: .leading) {
            HStack(spacing: 15) {
                Image(item.image)
                Text(item.title)
                    .font(.system(size: 20))
                    .foregroundStyle(.appGreen)
                Spacer()
                if let countCircle = item.countCircle {
                    Circle()
                        .fill(
                            LinearGradient(colors: [.appGreen, .appLightGreen], startPoint: .bottom, endPoint: .top)
                        )
                        .frame(width: 30, height: 30)
                        .overlay(
                            Text(String(countCircle))
                                .foregroundStyle(.white)
                                .font(.system(size: 18))
                        )
                }
            }
            NavigationLink {
                AccountPaymentView()
            } label: {
                EmptyView()
            }
            .opacity(0.0)
        }
    }
}

#Preview {
    ProfileView()
}
