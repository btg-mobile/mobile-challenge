//
//  KeyboardViewModel.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import Foundation

/// `ViewModel` responsável por `KeyboardView`
final class KeyboardViewModel {
    /// Valor digitado no teclado.
    public var currencyValue: String = ""
    
    /// Conversor de adaptação do index ao valor correspondente na célula, para se adaptar aos padrões iOS.
    /// - Parameter index: valor correspondente ao index da célula.
    /// - Returns: valor representativo na célula.
    func convertValue(index: Int) -> String {
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
        
        return computedValue(value: value)
    }
    
    /// Validador dos valores digitados.
    /// - Parameter value: Valor digitado.
    /// - Returns: `String` com valor final digitado.
    private func computedValue(value: Int) -> String {
        switch value {
        case 0...9:
            currencyValue.append(String(value))
        case 10:
            if(currencyValueIsEmpty()) { currencyValue.append("0") }
            if(isValidComma()) { currencyValue.append(",") }
        case 11:
            if (!currencyValueIsEmpty()) { currencyValue.removeLast() }
        default:
            break
        }
        return currencyValue
    }
    
    /// Verifica se o valor atual digitado é vazio.
    /// - Returns: `true` se o valor atual é vazio, caso contrário, retorna `false`.
    public func currencyValueIsEmpty() -> Bool {
        return currencyValue == ""
    }
    
    
    /// valida a existencia de vígulas no valor digitado
    /// - Returns: `true` se o valor atual não tiver vírgulas, caso contrário, retorna `false`.
    private func isValidComma() -> Bool {
        return !currencyValue.contains(",")
    }
}
