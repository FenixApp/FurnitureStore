//
//  AuthorisationViewModel.swift
//  FurnitureStore
//
//  Created by Dmitriy Starozhilov on 07.05.2024.
//

import Foundation

/// Вью модель экрана авторизации
final class AuthorisationViewModel: ObservableObject {

    @Published var passwordIsHide = true

    let phoneMask = "+X(XXX)XXX-XX-XX"

    func format(phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for char in phoneMask where index < numbers.endIndex {
            if char == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }
}
