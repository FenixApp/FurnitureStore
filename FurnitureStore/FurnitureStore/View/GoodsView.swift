//
//  GoodsView.swift
//  FurnitureStore
//
//  Created by Dmitriy Starozhilov on 09.05.2024.
//

import SwiftUI

/// Раздел с каталогом товаров
struct GoodsView: View {
    
    private enum Constants {
        static let magnifyingglass = "magnifyingglass"
        static let search = "Search..."
        static let totalPrice = "Your total price"
        static let minus = "-"
        static let plus = "+"
    }
    
    @ObservedObject var goodsViewModel = GoodsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    navigationBarView
                        .frame(height: 100)
                    totalPriceView
                    catalogScrollView
                }
            }
        }
    }
    
    private var navigationBarView: some View {
        ZStack {
            LinearGradient(colors: [.appLightGreen, .appGreen], startPoint: .leading, endPoint: .trailing)
                .frame(height: 150)
                .ignoresSafeArea(edges: .top)
            HStack(spacing: -15) {
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(.white)
                        .frame(width: 312, height: 48)
                    HStack {
                        Image(systemName: Constants.magnifyingglass)
                            .foregroundStyle(.gray)
                        Text(Constants.search)
                            .font(.system(size: 20))
                            .foregroundStyle(.gray)
                        Spacer().frame(width: 160)
                    }
                    .frame(width: 312, height: 48)
                }
                .padding()
                NavigationLink(destination: FilterView()) {
                    Image(.filter)
                        .padding()
                }
            }
        }
    }
    
    private var totalPriceView: some View {
        ZStack {
            Rectangle()
                .fill(.appLightGreen)
                .frame(width: 300, height: 48)
                .cornerRadius(12)
            HStack(spacing: -20) {
                Text(Constants.totalPrice)
                    .font(.system(size: 22))
                    .frame(width: 200, height: 28)
                    .foregroundStyle(.appGreen)
                Text("\(goodsViewModel.allPrice)$")
                    .fontWeight(.bold)
                    .frame(width: 98, height: 28)
                    .foregroundColor(.appGreen)
                    .font(.system(size: 24))
                Spacer().frame(width: 50)
            }
        }
        .padding(.trailing, -150)
    }
    
    private var catalogScrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(goodsViewModel.products.indices, id: \.self) { index in
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.appGoods)
                        .frame(width: 360, height: 150)
                        .shadow(color: .gray, radius: 1, x:0, y: 2)
                        .padding(.bottom, 15)
                    HStack {
                        NavigationLink {
                            DetailView()
                        } label: {
                            Image(goodsViewModel.products[index].image)
                                .resizable()
                                .frame(width: 140, height: 140)
                        }
                        VStack {
                            Text(goodsViewModel.products[index].name)
                                .fontWeight(.bold)
                                .font(.system(size: 22))
                                .foregroundStyle(.appDarkGray)
                            HStack {
                                Text("\(goodsViewModel.products[index].cost)$")
                                    .fontWeight(.bold)
                                    .frame(width: 100, height: 29)
                                    .font(.system(size: 24))
                                    .foregroundStyle(.appLightGreen)
                                if #available(iOS 16.0, *) {
                                    Text("\(goodsViewModel.products[index].oldPrice)")
                                        .font(.system(size: 24))
                                        .foregroundStyle(.appGreen)
                                        .strikethrough()
                                }
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(.appBeige)
                                    .frame(width: 115, height: 40)
                                HStack(spacing: 25) {
                                    Button {
                                        goodsViewModel.decrementPrice(index: index)
                                    } label: {
                                        Text(Constants.minus)
                                            .font(.system(size: 18))
                                    }
                                    .tint(.black)
                                    Text("\(goodsViewModel.products[index].numberProducts)")
                                        .fontWeight(.bold)
                                        .font(.system(size: 18))
                                    Button {
                                        goodsViewModel.incrementPrice(index: index)
                                    } label: {
                                        Text(Constants.plus)
                                            .fontWeight(.bold)
                                            .font(.system(size: 18))
                                    }
                                    .tint(.black)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    GoodsView()
}
