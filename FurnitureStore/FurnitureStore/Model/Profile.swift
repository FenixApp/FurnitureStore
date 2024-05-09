//
//  Profile.swift
//  FurnitureStore
//
//  Created by Dmitriy Starozhilov on 09.05.2024.
//

import Foundation

/// Профиль
struct Profile: Identifiable {
    /// Идентификатор
    let id = UUID()
    /// Картинка
    let image: String
    /// Заголовок
    let title: String
    /// Активен ли кружок
    var isCircleActivated: Bool
    /// Счетчик в кружочке
    var countCircle: Int?
}
