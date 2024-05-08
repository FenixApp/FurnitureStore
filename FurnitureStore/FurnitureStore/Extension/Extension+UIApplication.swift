//
//  Extension+UIApplication.swift
//  FurnitureStore
//
//  Created by Dmitriy Starozhilov on 08.05.2024.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
