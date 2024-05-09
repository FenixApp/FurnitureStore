//
//  Product.swift
//  FurnitureStore
//
//  Created by Dmitriy Starozhilov on 09.05.2024.
//

import Foundation

/// Продукт
struct Product {
    /// Наименование
    let name: String
    /// Картинка
    let image: String
    /// Цена
    let cost: Int
    /// Старая цена
    let oldPrice: String
    /// Количество
    var numberProducts: Int
}
