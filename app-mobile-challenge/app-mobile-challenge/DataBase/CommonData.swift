//
//  CommonData.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Foundation

/// Banco de dados baseado em UserDefaults.
final class CommonData {
    
    /// Padrão de projetos: Singleton
    private init() {}
    static let shared = CommonData()
    
    
    ///Moeda selecionada para a convertção.
    @UserDefaultAccess(key: "fromCurrency", defaultValue: "USD")
    public var fromCurrencyStorage: String
    
    ///Moeda selecionada para ser convertida.
    @UserDefaultAccess(key: "toCurrency", defaultValue: "USD")
    public var toCurrencyStorage: String
    
    ///Tipo de transição possível entre telas.
    @UserDefaultAccess(key: "selectedTypeCurrency", defaultValue: "none")
    public var selectedTypeCurrency: String
    
    ///Conjunto de moedas favoritas.
    @UserDefaultAccess(key: "favorites", defaultValue: [])
    public var favorites: [String]
    
    ///Lista de moedas para a conversão.
    @UserDefaultAccess(key: "lists", defaultValue: [])
    public var lists: Lists
    
    ///Tabela de valores das moedas para a conversão.
    @UserDefaultAccess(key: "lives", defaultValue: [])
    public var lives: Lives
    
    ///Valor que define quando foi a última atualização.
    @UserDefaultAccess(key: "lastUpdate", defaultValue: .zero)
    public var lastUpdate: Int
}
