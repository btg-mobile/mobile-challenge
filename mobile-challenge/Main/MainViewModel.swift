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
  var dataBase : AppDataBase?
  
  init(application: AppDelegate) {
    dataBase = application.dataBase
    guard let clientApi = application.clientApi else { return }
    getQuote(clientApi)
    getCurrency(clientApi)
  }
  
  private func getCurrency(_ clientApi: ClientApi) {
    clientApi.fetchCurrencyList { (response) in
      switch (response) {
      case .SucessResponse(let data): do {
        self.handleCurrencySucess(data)
        }
      case .ErrorResponse(let message): do {
        self.error.property = message
        self.setCurrencyFromDb()
        print(message)
        }
      }
    }
  }
  
  private func handleCurrencySucess(_ data: (CurrencyResponse)) {
    if data.success || !data.currencies.isEmpty{
      self.updateCurrencyTableDB(data: data)
    } else {
      self.error.property = "Error while fetching data"
      self.setCurrencyFromDb()
      print("False Sucess")
    }
  }
  
  private func updateCurrencyTableDB(data: CurrencyResponse){
    let sortedCurrency = data.currencies.sorted(by: { (first, second) -> Bool in
      first.key < second.key
    })
    var id = 1
    var list = [] as [CurrencyEntity]
    sortedCurrency.forEach { (dic) in
      let currency = CurrencyEntity(
        id,
        dic.key,
        dic.value)
      list.append(currency)
      id+=1
    }
    self.currencyList = list
    // Update Data base
    self.dataBase?.insertOrUpdateListCurrencyEntityTable(list: list)
  }
  
  private func setCurrencyFromDb() {
    print("DATABASE \(String(describing: dataBase))")
    let list = dataBase?.selectAllCurrencyEntityTable()
    print("CURRENCY LIST \(String(describing: list))")
    if (list!.count > 0) {
      currencyList = list!
    }
  }
  
  private func getQuote(_ clientApi: ClientApi) {
    clientApi.fetchQuoteLive { (response) in
      switch (response) {
      case .SucessResponse(let data): do {
        self.handleQuoteSucess(data)
        }
      case .ErrorResponse(let message): do {
        self.error.property = message
        self.setQuoteFromDb()
        print(message)
        }
      }
    }
  }
  
  private func handleQuoteSucess(_ data: (QuoteResponse)) {
    if data.success || !data.quotes.isEmpty{
      updateQuoteTableDB(data: data)
      setQuoteValue(code: "BRL", type: "TO")
    } else {
      self.error.property = "Error while fetching data"
      self.setQuoteFromDb()
      print("False Sucess")
    }
  }
  
  func updateQuoteTableDB(data: QuoteResponse) {
    let sortedQuotes = data.quotes.sorted(by: { (first, second) -> Bool in
      first.key < second.key
    })
    var id = 1
    var quoteList = [] as [QuoteEntity]
    sortedQuotes.forEach { (quote) in
      let quoteEntity = QuoteEntity(
        id,
        quote.key.substring(to: 3),
        quote.key.substring(from: 3),
        quote.value)
      quoteList.append(quoteEntity)
      id+=1
    }
    self.quotes = quoteList
    // update database
    self.dataBase?.insertOrUpdateListQuoteEntityTable(list: quoteList)
  }
  
  private func setQuoteFromDb() {
    let quoteList = dataBase?.selectAllQuoteEntityTable()
    print("QUOTE LIST \(String(describing: quoteList))")
    if (quoteList!.count > 0) {
      self.quotes = quoteList!
      setQuoteValue(code: "BRL", type: "TO")
    }
  }
  
  func setQuoteValue(code: String, type: String) {
    let value = self.quotes.filter { (quote) -> Bool in quote.to == code }
    print("QUOTE value \(String(describing: value))")
    if (value as [QuoteEntity]?) != nil && value.count > 0 {
      if (type == "FROM") {
        self.currencyFrom = 1 / value[0].value
        fromCode.property = (code)
      } else {
        self.currencyTo = value[0].value
        toCode.property = (code)
      }
      liveValue.property = (currencyFrom * currencyTo)
    }
  }
}
