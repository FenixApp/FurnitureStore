//
//  DetailView.swift
//  FurnitureStore
//
//  Created by Dmitriy Starozhilov on 07.05.2024.
//

import SwiftUI

/// Экран с детальным описанием товара
struct DetailView: View {
    
    private struct Constants {
        static let heart = "heart"
        static let heartFill = "heart.fill"
        static let currency = "$"
        static let price = "Price:"
        static let article = "Article"
        static let description = "Description"
        static let review = "Review"
        static let buyNow = "Buy now"
        static let maxReviewLength = 300
        static let sofaElda = "Sofa Elda 900"
        static let heartImage = "heart"
        static let sofaImageName = "sofa"
        static let price999 = "Price: 999$"
        static let numbers = "283564"
        static let descriptionText = "A sofa in a modern style is furniture without lush omate decor. It has a simple or even futuristic appearance and sleek design."
    }
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                HeadView
                ImageView
                DescriptionView
            }
        }
    }
    
    @State private var review = ""
    
    private var HeadView: some View {
        HStack(spacing: 200) {
            Text(Constants.sofaElda)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(.appGreen)
            Button {
            } label: {
                Image(systemName: Constants.heartImage)
                    .foregroundStyle(.black)
            }
        }
    }
    
    private var ImageView: some View {
        VStack {
            Image(Constants.sofaImageName)
            Text(Constants.price999)
                .fontWeight(.bold)
                .font(.system(size: 20))
                .frame(width: 180, height: 44)
                .background(Color.appBrown)
                .foregroundStyle(.appGreen)
                .cornerRadius(10)
                .offset(x: 8)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    private var DescriptionView: some View {
        ZStack {
            LinearGradient(colors: [.appLightGreen, .appGreen], startPoint: .top, endPoint: .bottom)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .ignoresSafeArea()
            VStack(spacing: 32) {
                VStack(alignment: .leading, spacing: 9) {
                    Text(
                        makeAttributedDescriptionString(
                            title: Constants.article,
                            text: Constants.numbers
                        )
                    )
                    Text(
                        makeAttributedDescriptionString(
                            title: Constants.description,
                            text: Constants.descriptionText
                        )
                    )
                    Text(Constants.review)
                        .fontWeight(.bold)
                        .padding(.leading, 150)
                    HStack(alignment: .top, spacing: 5) {
                        if #available(iOS 16.0, *) {
                            TextEditor(text: $review)
                                .scrollContentBackground(.hidden)
                                .background(.clear)
                        } else {
                            TextEditor(text: $review)
                        }
                        Text("\(review.count)/\(Constants.maxReviewLength)")
                            .font(.system(size: 14))
                    }
                }
                buyNowButtonView
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .foregroundStyle(.white)
            .padding(.vertical, 24)
            .padding(.horizontal, 20)
        }
        
    }
    
    private var buyNowButtonView: some View {
        Button {
        } label: {
            ZStack {
                Color(.white)
                Text(Constants.buyNow)
                    .fontWeight(.bold)
                    .foregroundStyle(.linearGradient(colors: [.appGreen, .appLightGreen], startPoint: .top, endPoint: .bottom))
                    .font(.system(size: 24))
            }
        }
        .frame(width: 300, height: 55)
        .clipShape(RoundedRectangle(cornerRadius: 26))
        .shadow(color: .appGreen, radius: 2, x: 0.0, y: 3.0)
    }
    
    private func makeAttributedDescriptionString(title: String, text: String) -> AttributedString {
        var titleText = AttributedString(title + ": ")
        titleText.font = .system(size: 16, weight: .bold)
        return titleText + AttributedString(text)
    }
}

#Preview {
    DetailView()
}
