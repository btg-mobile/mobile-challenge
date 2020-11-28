//
//  KeyboardViewModel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import Foundation

final class KeyboardViewModel {
    func convertValue(index: Int) -> Int {
        var value: Int = 0
        switch index {
        case 0:
            value = 7
        case 1:
            value = 8
        case 2:
            value = 9
        case 3:
            value = 4
        case 4:
            value = 5
        case 5:
            value = 6
        case 6:
            value = 1
        case 7:
            value = 2
        case 8:
            value = 3
        case 9:
            value = 0
        default:
            value = index
        }
        return value
    }
}
