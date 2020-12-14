//
//  AvailableCurrencies.swift
//  CurrencyLayer
//
//  Created by Filipe Cruz on 12/12/20.
//

import SwiftUI

struct AvailableCurrencies: View {
  @Environment(\.presentationMode) var presentation
  
  var currencies: [String: String]
  @Binding var currencyItem: String
  var screenWidth = UIScreen.main.bounds.width

  var body: some View {
    ZStack {
      Color.init("color_primary_background").edgesIgnoringSafeArea(.all)
      List(currencies.sorted(by: <), id: \.key) {  key, value in
        HStack {
          Text(key + " - " + value)
//            .foregroundColor(.white)
          Spacer()
        }
        .contentShape(Rectangle())
        .frame(
            maxWidth: .infinity,
            maxHeight: 150,
            alignment: .center
        )
        .listRowInsets(EdgeInsets())
        .onTapGesture { setChoosenCurrencieAndDismiss(key: key) }
      }
      .navigationBarTitle(Text("Supported currencies"))
      .listStyle(GroupedListStyle())
    }
  }
  
  func setChoosenCurrencieAndDismiss(key: String) {
    self.currencyItem = key
    self.presentation.wrappedValue.dismiss()
  }
}
