//
//  Protocols.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import UIKit

protocol ResultViewDelegate {
  func openSelectionViewControler( button : UIButton )
}

protocol ClientApiDelegate : class {
  func fetchCurrencyList(completionHandler: @escaping (ResponseOptionsCurrency) -> Void)
  func fetchQuoteLive(completionHandler: @escaping (ResponseOptionsQuote) -> Void)
}

