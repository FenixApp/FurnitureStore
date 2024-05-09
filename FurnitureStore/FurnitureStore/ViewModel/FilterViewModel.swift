//
//  FilterViewModel.swift
//  FurnitureStore
//
//  Created by Dmitriy Starozhilov on 10.05.2024.
//

import SwiftUI

/// Вью модель для раздела с фильтрами товаров
class FilterViewModel: ObservableObject {
    @Published var categories = ["BedCategory", "SofaCategory", "ChairCategory"]
    @Published var colors: [Color] = [.white, .black, .gray, .pink, .orange, .red, .blue, .green, .cyan, .indigo, .brown, .purple, .appBeige, .appBrown, .appDarkGray, .appGoods, .appGray, .appGreen, .appLightGreen, .accentColor]
}
