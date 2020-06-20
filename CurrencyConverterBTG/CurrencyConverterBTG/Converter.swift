//
//  Converter.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 19/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

class Converter: NSObject {
    
    let baseFreeCurrency: Currency? = nil    //= Currency(code: "USD", name: "United States Dollar")
    
    
    func convert(_ conversion: Conversion) {
        // trazer a conversão do dolar, só pode dolar no free
        
        //Exemplo:
        
        // from BRL to AUD = converter 20 reais
        
        // USDAUD   1.461134  -> 1 USD = 1.461134 AUD
        // USDBRL   5.333303  -> 1 USD = 5.333303 BRL

        // 1 - 5.3
        // 20 - x
        // x = 20 * 5.3 = 106
        
        
        // 5.33 brl - 1 usd - 1.46 aud
        // 20 brl   - x usd - y aud
        
        
        // Formula :
        // ( moeda destino / moeda fonte ) * valor a ser convertido na moeda fonte  =  total na moeda destino
        
        
    }
    
    
}
