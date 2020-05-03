//
//  MainViewModel.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import Foundation

class MainViewModel {
  
  // Handle Error
  let error = Observable<String>()

  // Live currency value
  let liveValue = Observable<Double>()

  // Update "FROM" button
  let fromCode = Observable<String>()

  // Update "TO" button
  let toCode = Observable<String>()
  
  var currencyList = [] as [CurrencyEntity]
  var quotes = [] as [QuoteEntity]
  var currencyFrom = 1.0
  var currencyTo = 1.0
  
  init(application: AppDelegate) {
    guard let clientApi = application.clientApi else { return }
    getCurrency(clientApi)
    getQuote(clientApi)
  }

  private func getCurrency(_ clientApi: ClientApi) {
    clientApi.fetchCurrencyList { (response) in
      switch (response) {
      case .SucessResponse(let data): do {
        self.handleCurrencySucess(data)
        }
      case .ErrorResponse(let message): do {
        self.error.property = message
        print(message)
        }
      }
    }
  }
  
  private func handleCurrencySucess(_ data: (CurrencyResponse)) {
    if data.success || !data.currencies.isEmpty{
      self.setCurrencyFromNetwork(data: data)
    } else {
      self.error.property = "Error while fetching data"
      print("False Sucess")
    }
  }
  
  func setCurrencyFromNetwork(data: CurrencyResponse){
    let currenciesDic = data.currencies
    var currenciesList = [] as [CurrencyEntity]
    currenciesDic.forEach { (dic) in
      let currency = CurrencyEntity(UUID().uuidString, dic.key, currencyName: dic.value)
      currenciesList.append(currency)
    }
    self.currencyList = currenciesList
  }
  
  private func getQuote(_ clientApi: ClientApi) {
    clientApi.fetchQuoteLive { (response) in
      switch (response) {
      case .SucessResponse(let data): do {
        self.handleQuoteSucess(data)
        }
      case .ErrorResponse(let message): do {
        self.error.property = message
        print(message)
        }
      }
    }
  }
  
  private func handleQuoteSucess(_ data: (QuoteResponse)) {
    if data.success || !data.quotes.isEmpty{
      updateDataBase(data: data)
      setQuoteValue(code: "BRL", type: "TO")
    } else {
      self.error.property = "Error while fetching data"
      print("False Sucess")
    }
  }
  
  func updateDataBase(data: QuoteResponse) {
    var quoteList = [] as [QuoteEntity]
    data.quotes.forEach { (quote) in
      let quoteEntity = QuoteEntity(
        _id: UUID().uuidString,
        from: quote.key.substring(to: 3),
        to: quote.key.substring(from: 3),
        value: quote.value)
      quoteList.append(quoteEntity)
    }
    // update database
    self.quotes = quoteList
  }
  
  func setQuoteValue(code: String, type: String) {
    let value = self.quotes.filter { (quote) -> Bool in quote.to == code }[0]
    if (type == "FROM") {
      self.currencyFrom = 1 / value.value
      fromCode.property = (code)
    } else {
      self.currencyTo = value.value
      toCode.property = (code)
    }
    liveValue.property = (currencyFrom * currencyTo)
  }
}
