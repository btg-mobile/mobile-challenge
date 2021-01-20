//
//  Cambio.swift
//  conversorDeMoeda
//
//  Created by Diogenes de Souza on 08/01/21.
//

import Foundation

// MARK: modelo de dados da API
struct Cambio : Codable {
    typealias DicType = [String: String]
    let terms: URL?
    let privacy: URL?
    let currencies: DicType
    
}

struct Moeda {
    var nome:String?
    var sigla:String?
    var valor:Double?
}

struct Cotacao : Codable{
    typealias DicType = [String: Double]
    let terms: URL?
    let privacy: URL?
    let quotes:DicType
    
}



