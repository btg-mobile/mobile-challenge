import Foundation
import Combine
class CurrencyConversionViewModel: ObservableObject {
  @Published private(set) var state = CurrencyLayerState()
  private var subscriptions = Set<AnyCancellable>()
  private var fetcher: CurrencyLayerFetcher
  
  init() {
    fetcher = CurrencyLayerFetcher()
  }
  
  func fetchCurrecyListAndCurrencies() {

    fetcher.getCurrencyExangeList()
        .receive(on: DispatchQueue.main)
        .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure(let error):
              print(error.localizedDescription)
              self.subscriptions = []
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] forecast in
            guard let self = self else { return }
            self.state.exangeRates = forecast.quotes
            self.fetchSupportedCurrencies()
        })
        .store(in: &subscriptions)
  }
  
  func fetchSupportedCurrencies() {
    fetcher.getSupportedCurrencies()
        .receive(on: DispatchQueue.main)
        .sink(
          receiveCompletion: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .failure:
              self.subscriptions = []
            case .finished:
              break
            }
          },
          receiveValue: { [weak self] forecast in
            guard let self = self else { return }
            self.state.currencies = forecast.currencies
        })
        .store(in: &subscriptions)
  }
}

struct CurrencyLayerState {
  var isLoading = false
  var exangeRates = [String:Double]()
  var currencies = [String:String]()
}
