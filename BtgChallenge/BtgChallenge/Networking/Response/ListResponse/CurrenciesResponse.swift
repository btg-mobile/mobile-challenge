//
//  CurrenciesResponse.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 15/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

struct CurrenciesResponse: Codable {
    let AED: String?
    let AFN: String?
    let ALL: String?
    let AMD: String?
    let ANG: String?
    let AOA: String?
    let ARS: String?
    let AUD: String?
    let AWG: String?
    let AZN: String?
    let BAM: String?
    let BBD: String?
    let BDT: String?
    let BGN: String?
    let BHD: String?
    let BIF: String?
    let BMD: String?
    let BND: String?
    let BOB: String?
    let BRL: String?
    let BSD: String?
    let BTC: String?
    let BTN: String?
    let BWP: String?
    let BYR: String?
    let BZD: String?
    let CAD: String?
    let CDF: String?
    let CHF: String?
    let CLF: String?
    let CLP: String?
    let CNY: String?
    let COP: String?
    let CRC: String?
    let CUC: String?
    let CUP: String?
    let CVE: String?
    let CZK: String?
    let DJF: String?
    let DKK: String?
    let DOP: String?
    let DZD: String?
    let EGP: String?
    let ERN: String?
    let ETB: String?
    let EUR: String?
    let FJD: String?
    let FKP: String?
    let GBP: String?
    let GEL: String?
    let GGP: String?
    let GHS: String?
    let GIP: String?
    let GMD: String?
    let GNF: String?
    let GTQ: String?
    let GYD: String?
    let HKD: String?
    let HNL: String?
    let HRK: String?
    let HTG: String?
    let HUF: String?
    let IDR: String?
    let ILS: String?
    let IMP: String?
    let INR: String?
    let IQD: String?
    let IRR: String?
    let ISK: String?
    let JEP: String?
    let JMD: String?
    let JOD: String?
    let JPY: String?
    let KES: String?
    let KGS: String?
    let KHR: String?
    let KMF: String?
    let KPW: String?
    let KRW: String?
    let KWD: String?
    let KYD: String?
    let KZT: String?
    let LAK: String?
    let LBP: String?
    let LKR: String?
    let LRD: String?
    let LSL: String?
    let LTL: String?
    let LVL: String?
    let LYD: String?
    let MAD: String?
    let MDL: String?
    let MGA: String?
    let MKD: String?
    let MMK: String?
    let MNT: String?
    let MOP: String?
    let MRO: String?
    let MUR: String?
    let MVR: String?
    let MWK: String?
    let MXN: String?
    let MYR: String?
    let MZN: String?
    let NAD: String?
    let NGN: String?
    let NIO: String?
    let NOK: String?
    let NPR: String?
    let NZD: String?
    let OMR: String?
    let PAB: String?
    let PEN: String?
    let PGK: String?
    let PHP: String?
    let PKR: String?
    let PLN: String?
    let PYG: String?
    let QAR: String?
    let RON: String?
    let RSD: String?
    let RUB: String?
    let RWF: String?
    let SAR: String?
    let SBD: String?
    let SCR: String?
    let SDG: String?
    let SEK: String?
    let SGD: String?
    let SHP: String?
    let SLL: String?
    let SOS: String?
    let SRD: String?
    let STD: String?
    let SVC: String?
    let SYP: String?
    let SZL: String?
    let THB: String?
    let TJS: String?
    let TMT: String?
    let TND: String?
    let TOP: String?
    let TRY: String?
    let TTD: String?
    let TWD: String?
    let TZS: String?
    let UAH: String?
    let UGX: String?
    let USD: String?
    let UYU: String?
    let UZS: String?
    let VEF: String?
    let VND: String?
    let VUV: String?
    let WST: String?
    let XAF: String?
    let XAG: String?
    let XAU: String?
    let XCD: String?
    let XDR: String?
    let XOF: String?
    let XPF: String?
    let YER: String?
    let ZAR: String?
    let ZMK: String?
    let ZMW: String?
    let ZWL: String?
}

extension CurrenciesResponse {
    var coinStrategy: [String: String?] {
        return [
            "AED": AED,
            "AFN": AFN,
            "ALL": ALL,
            "AMD": AMD,
            "ANG": ANG,
            "AOA": AOA,
            "ARS": ARS,
            "AUD": AUD,
            "AWG": AWG,
            "AZN": AZN,
            "BAM": BAM,
            "BBD": BBD,
            "BDT": BDT,
            "BGN": BGN,
            "BHD": BHD,
            "BIF": BIF,
            "BMD": BMD,
            "BND": BND,
            "BOB": BOB,
            "BRL": BRL,
            "BSD": BSD,
            "BTC": BTC,
            "BTN": BTN,
            "BWP": BWP,
            "BYR": BYR,
            "BZD": BZD,
            "CAD": CAD,
            "CDF": CDF,
            "CHF": CHF,
            "CLF": CLF,
            "CLP": CLP,
            "CNY": CNY,
            "COP": COP,
            "CRC": CRC,
            "CUC": CUC,
            "CUP": CUP,
            "CVE": CVE,
            "CZK": CZK,
            "DJF": DJF,
            "DKK": DKK,
            "DOP": DOP,
            "DZD": DZD,
            "EGP": EGP,
            "ERN": ERN,
            "ETB": ETB,
            "EUR": EUR,
            "FJD": FJD,
            "FKP": FKP,
            "GBP": GBP,
            "GEL": GEL,
            "GGP": GGP,
            "GHS": GHS,
            "GIP": GIP,
            "GMD": GMD,
            "GNF": GNF,
            "GTQ": GTQ,
            "GYD": GYD,
            "HKD": HKD,
            "HNL": HNL,
            "HRK": HRK,
            "HTG": HTG,
            "HUF": HUF,
            "IDR": IDR,
            "ILS": ILS,
            "IMP": IMP,
            "INR": INR,
            "IQD": IQD,
            "IRR": IRR,
            "ISK": ISK,
            "JEP": JEP,
            "JMD": JMD,
            "JOD": JOD,
            "JPY": JPY,
            "KES": KES,
            "KGS": KGS,
            "KHR": KHR,
            "KMF": KMF,
            "KPW": KPW,
            "KRW": KRW,
            "KWD": KWD,
            "KYD": KYD,
            "KZT": KZT,
            "LAK": LAK,
            "LBP": LBP,
            "LKR": LKR,
            "LRD": LRD,
            "LSL": LSL,
            "LTL": LTL,
            "LVL": LVL,
            "LYD": LYD,
            "MAD": MAD,
            "MDL": MDL,
            "MGA": MGA,
            "MKD": MKD,
            "MMK": MMK,
            "MNT": MNT,
            "MOP": MOP,
            "MRO": MRO,
            "MUR": MUR,
            "MVR": MVR,
            "MWK": MWK,
            "MXN": MXN,
            "MYR": MYR,
            "MZN": MZN,
            "NAD": NAD,
            "NGN": NGN,
            "NIO": NIO,
            "NOK": NOK,
            "NPR": NPR,
            "NZD": NZD,
            "OMR": OMR,
            "PAB": PAB,
            "PEN": PEN,
            "PGK": PGK,
            "PHP": PHP,
            "PKR": PKR,
            "PLN": PLN,
            "PYG": PYG,
            "QAR": QAR,
            "RON": RON,
            "RSD": RSD,
            "RUB": RUB,
            "RWF": RWF,
            "SAR": SAR,
            "SBD": SBD,
            "SCR": SCR,
            "SDG": SDG,
            "SEK": SEK,
            "SGD": SGD,
            "SHP": SHP,
            "SLL": SLL,
            "SOS": SOS,
            "SRD": SRD,
            "STD": STD,
            "SVC": SVC,
            "SYP": SYP,
            "SZL": SZL,
            "THB": THB,
            "TJS": TJS,
            "TMT": TMT,
            "TND": TND,
            "TOP": TOP,
            "TRY": TRY,
            "TTD": TTD,
            "TWD": TWD,
            "TZS": TZS,
            "UAH": UAH,
            "UGX": UGX,
            "USD": USD,
            "UYU": UYU,
            "UZS": UZS,
            "VEF": VEF,
            "VND": VND,
            "VUV": VUV,
            "WST": WST,
            "XAF": XAF,
            "XAG": XAG,
            "XAU": XAU,
            "XCD": XCD,
            "XDR": XDR,
            "XOF": XOF,
            "XPF": XPF,
            "YER": YER,
            "ZAR": ZAR,
            "ZMK": ZMK,
            "ZMW": ZMW,
            "ZWL": ZWL
        ]
    }
}
