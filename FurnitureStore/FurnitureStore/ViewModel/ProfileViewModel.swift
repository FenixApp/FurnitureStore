//
//  ProfileViewModel.swift
//  FurnitureStore
//
//  Created by Dmitriy Starozhilov on 09.05.2024.
//

import SwiftUI

/// Вью модель для раздела "Профиль"
class ProfileViewModel: ObservableObject {
    @Published var listInfoProfile: [Profile] = [
        .init(image: "Envelope", title: "Sity", isCircleActivated: true, countCircle: 3),
        .init(image: "Bell", title: "Notification", isCircleActivated: true, countCircle: 4),
        .init(image: "User", title: "Accounts Details", isCircleActivated: false),
        .init(image: "BasketUser", title: "My purchases", isCircleActivated: false),
        .init(image: "Gear", title: "Settings", isCircleActivated: false)
    ]
}
