//
//  MainTabBarView.swift
//  FurnitureStore
//
//  Created by Dmitriy Starozhilov on 09.05.2024.
//

import SwiftUI

/// Таб бар с разделами
struct MainTabBarView: View {
    
    var body: some View {
        TabView(selection: $selectedTab) {
            GoodsView()
                .tabItem {
                    Image(.house)
                        .renderingMode(.template)
                }
                .tag(0)
            BasketView()
                .tabItem {
                    Image(.basket)
                        .renderingMode(.template)
                }
                .tag(1)
            ProfileView()
                .tabItem {
                    Image(.smile)
                        .renderingMode(.template)
                }
                .tag(2)
        }
        .tint(.appLightGreen)
    }
    
    @State private var selectedTab = 0
}

#Preview {
    MainTabBarView()
}
