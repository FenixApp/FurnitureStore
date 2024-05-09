//
//  GoodsViewModel.swift
//  FurnitureStore
//
//  Created by Dmitriy Starozhilov on 09.05.2024.
//

import Foundation

/// Вью модель для раздела с каталогом товаров
class GoodsViewModel: ObservableObject {
    @Published var allPrice = 0
    @Published var numberProducts = 0
    @Published var products: [Product] = [
        .init(name: "Sofa", image: "RedDivan", cost: 999, oldPrice: "2000$", numberProducts: 0),
        .init(name: "Armchair", image: "GrayChair", cost: 99, oldPrice: "200$", numberProducts: 0),
        .init(name: "Bed", image: "Bed", cost: 1000, oldPrice: "2000$", numberProducts: 0),
        .init(name: "Table", image: "WoodenTable", cost: 600, oldPrice: "1200$", numberProducts: 0),
        .init(name: "Сhair", image: "BlueChair", cost: 99, oldPrice: "200$", numberProducts: 0),
        .init(name: "Wardrobe", image: "Wardrobe", cost: 899, oldPrice: "1100$", numberProducts: 0),
    ]
    
    func decrementPrice(index: Int) {
        if allPrice > 0 && products[index].numberProducts > 0 {
            products[index].numberProducts -= 1
            allPrice -= products[index].cost
        }
    }
    
    func incrementPrice(index: Int) {
        products[index].numberProducts += 1
        allPrice += products[index].cost
    }
}
