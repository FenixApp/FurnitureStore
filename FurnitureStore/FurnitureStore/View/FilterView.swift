//
//  FilterView.swift
//  FurnitureStore
//
//  Created by Dmitriy Starozhilov on 10.05.2024.
//

import SwiftUI

/// Раздел с фильтрацией товаров
struct FilterView: View {
    
    private enum Constants {
        static let name = "Your Name"
        static let city = "City"
        static let title = "Filters"
        static let category = "Category"
        static let more = "More"
        static let prices = "Prices"
        static let color = "Color - "
        static let dollarSign = "$"
        static let chevronLeft = "chevron.left"
        static let chevronForward = "chevron.forward"
        static let notihingSelected = "please choose"
        static let priceRange = 500.0...5000.0
        static let step = 500.0
        static let currentPrice = 3500.0
    }
    
    @ObservedObject var filterViewModel = FilterViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                    .frame(height: 20)
                categoryView
                    .frame(height: 180)
                pricesSliderView
                chooseColorView
                    .padding(.top)
            }
        }
        .onAppear() {
            UISlider.appearance().minimumTrackTintColor = .appLightGreen
            UISlider.appearance().setThumbImage(.thumb, for: .normal)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: Constants.chevronLeft)
                        .tint(.white)
                })
            }
            ToolbarItem(placement: .principal) {
                Text(Constants.title)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
        }
        Spacer()
    }
    
    private var headerView: some View {
        VStack {
            LinearGradient(colors: [.appLightGreen, .appGreen], startPoint: .leading, endPoint: .trailing)
                .frame(height: 100)
                .ignoresSafeArea(edges: .top)
        }
    }
    
    private var categoryView: some View {
        VStack(spacing: 1) {
            HStack {
                Text(Constants.category)
                    .fontWeight(.bold)
                    .font(.system(size: 22))
                    .foregroundStyle(.appDarkGray)
                Spacer()
                Group {
                    Text(Constants.more)
                        .fontWeight(.bold)
                        .font(.system(size: 22))
                        .foregroundStyle(.gray)
                    Image(systemName: Constants.chevronForward)
                        .foregroundStyle(.gray)
                }
            }
            .padding(.horizontal)
            ScrollView(.horizontal) {
                let rows = [GridItem()]
                LazyHGrid(rows: rows, spacing: 12, content: {
                    ForEach(filterViewModel.categories, id: \.self) { category in
                        makeCategoryView(category)
                    }
                })
            }
        }
    }
    
    private var pricesSliderView: some View {
        VStack(alignment: .leading) {
            Text(Constants.prices)
                .fontWeight(.bold)
                .font(.system(size: 22))
                .foregroundStyle(.appDarkGray)
                .padding(.leading)
            Slider(value: $priceProgress, in: Constants.priceRange, step: Constants.step)
                .padding(.horizontal)
            HStack {
                let minAmount = String(Int(Constants.priceRange.lowerBound))
                let maxAmount = String(Int(priceProgress))
                Text(Constants.dollarSign + minAmount)
                Spacer()
                Text(Constants.dollarSign + maxAmount)
            }
            .padding(.horizontal)
            .font(.system(size: 18))
            .offset(y: -10)
        }
    }
    
    private var chooseColorView: some View {
        VStack(alignment: .leading) {
            Text(Constants.color + selectedColorDescription)
                .fontWeight(.bold)
                .foregroundStyle(.appDarkGray)
                .font(.system(size: 24))
                .padding(.leading)
            let columns = [GridItem(), GridItem(), GridItem(), GridItem(), GridItem()]
            LazyVGrid(columns: columns, spacing: 10, content: {
                ForEach(filterViewModel.colors, id: \.self) { color in
                    if #available(iOS 17.0, *) {
                        Circle()
                            .fill(color)
                            .stroke(color == selectedColor ? .black : .gray,
                                    lineWidth: color == selectedColor ? 3 : 1)
                            .frame(width: 40, height: 40)
                            .onTapGesture {
                                selectedColor = color
                            }
                    }
                }
            }
            )}
    }
    
    private var selectedColorDescription: String {
        if let selectedColor {
            return selectedColor.description.capitalized
        } else {
            return Constants.notihingSelected
        }
    }
    
    private func makeCategoryView(_ imageName: String) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.appGoods)
            .frame(width: 120, height: 80)
            .shadow(radius: 3, y: 3)
            .overlay(
                Image(imageName)
                    .frame(width: 50, height: 50)
            )
    }
    
    @State private var priceProgress = Constants.currentPrice
    @State private var selectedColor: Color?
}

#Preview {
    FilterView()
}
