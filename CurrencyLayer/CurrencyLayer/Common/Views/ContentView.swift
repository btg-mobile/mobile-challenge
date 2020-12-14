import SwiftUI

struct ContentView: View {
    var screenHeight = UIScreen.main.bounds.height
    private var viewModel = CurrencyConversionViewModel()
    var body: some View {
      CurrencyConversionView(viewModel: viewModel)
        .onAppear(perform: viewModel.fetchCurrecyListAndCurrencies)
    }
}
