//
//  NetworkErrorConstants.swift
//  BTGConverterAPP
//
//  Created by Ana Caroline de Souza on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

enum BTGNetworkErrorConstants: String, Error {
    case invalidUrl = "This URL is invalid request. Please email us."
    case unableToComplete = "Unable to completed your request. Please check your internet"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
    case montlhyAttemptsOver = "Monthly attempts are over."
}

enum BTGCurrencyErrorConstants: String {
    case currencyEmptyTextField = "O valor está vazio. Por favor tente algum número. Ex: 23"
    case invalidCurrency = "O valor digitado não é valido. Por favor tente algum número. Ex: 23"
    case currenciesAreEmpty = "Existe moeda sem seleção. Por favor selecione duas moedas diferentes"
    case currenciesAreTheSame = "As duas moedas são iguais. Por favor selecione duas moedas diferentes"
}
