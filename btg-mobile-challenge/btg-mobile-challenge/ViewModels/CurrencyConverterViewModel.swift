//
//  CurrencyConverterViewModel.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import Foundation

/// The protocol responsible for establishing a communication path
/// between `CurrencyConverterViewModel` and `CurrencyViewController`.
protocol CurrencyConverterViewModelDelegate: AnyObject {
    /// Updates the UI of the View.
    func updateUI()
}

/// The `ViewModel` responsible for `CurrencyConverterViewController`.
final class CurrencyConverterViewModel {
    //- MARK: Properties
    typealias Quotes = [String: Double]
    /// The delegate responsible for `ViewModel -> View` binding.
    weak var delegate: CurrencyConverterViewModelDelegate?

    @UserDefaultAccess(key: CurrencyPickingCase.from.rawValue, defaultValue: "USD")
    private var fromCurrencyStorage: String

    @UserDefaultAccess(key: CurrencyPickingCase.to.rawValue, defaultValue: "BRL")
    private var toCurrencyStorage: String

    /// The manager responsible for network calls.
    private let networkManager: NetworkManager

    /// The cache for the network responses.
    private let networkCache: Cache

    /// The `Coordinator` associated with this `ViewModel`.
    private let coordinator: CurrencyConverterCoordinatorService

    /// The `USD` currency quotes.
    private var quotes: Quotes = [:]

    private var hasConnection: Bool = true {
        didSet {
            if hasConnection == false {
                fetch()
            }
        }
    }

    /// The last `LiveCurrencyResponse` request result.
    private var lastLiveResponse: LiveCurrencyReponse?

    /// The last `ListCurrencyResponse` request result.
    private var lastListResponse: ListCurrencyResponse?
    
    //- MARK: Init
    /// Initializes a new instance of this type.
    /// - Parameter networkManager: The manager responsible for network calls.
    /// - Parameter coordinator: The `Coordinator` associated with this `ViewModel`.
    /// - Parameter networkCache: The cache for the network responses.
    init(networkManager: NetworkManager,
         coordinator: CurrencyConverterCoordinator,
         networkCache: Cache = Cache()) {
        self.networkManager = networkManager
        self.coordinator = coordinator
        self.networkCache = networkCache
    }

    //- MARK: API
    /// The amount to be converted.
    var amount: String = "" {
        didSet {
            convertedAmount = convert(amount)
            delegate?.updateUI()
        }
    }

    /// The currency being converted from.
    var fromCurrency: String {
        return fromCurrencyStorage
    }

    /// The currency being converted to.
    var toCurrency: String {
        return toCurrencyStorage
    }

    /// The converted amount.
    var convertedAmount: String = ""

    /// Warns `Coordinator` to navigate to the currency picker screen.
    /// - Parameter case: The currency case picked by the user.
    func pickCurrency(_ case: CurrencyPickingCase) {
        guard let listResponse = lastListResponse else {
            return
        }

        coordinator.pickCurrency(`case`, currencies: listResponse)
    }

    /// Warns `Coordinator` to navigate to list of currencies screen.
    func listCurrencies() {
        guard let currencies = lastListResponse else {
            return
        }
        coordinator.showCurrencies(currencies)
    }

    // - MARK: Fetch
    /// Fetches data from `NetworkManager` and caches the result.
    /// If `NetworkCache.hasCache` is set to `true`, the fetch will return what
    /// is in cache.
    func fetch() {
        if networkCache.hasCache {
            networkCache.load(.live, for: LiveCurrencyReponse.self) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let live):
                    let trimmedQuotes = self.trimmedQuotes(live.quotes)
                    self.quotes = trimmedQuotes
                case .failure(_):
                    break
                    //- TODO: ERROR HANDLING
                }
            }

            networkCache.load(.list, for: ListCurrencyResponse.self) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let list):
                    self.lastListResponse = list
                case .failure(_):
                    break
                    //- TODO: ERROR HANDLING
                }
            }


        } else {
            fetchLive()
            fetchList()
        }
    }

    private func fetchLive() {
        guard let endpoint = Endpoint.live.url else {
            return
        }

        let urlRequest = URLRequest(url: endpoint)

        networkManager.perform(urlRequest, for: LiveCurrencyReponse.self) { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let live):
                self.lastLiveResponse = live
                let trimmedQuotes = self.trimmedQuotes(live.quotes)
                self.quotes = trimmedQuotes
                self.hasConnection = true
                self.cacheResponse()
            case .failure(let error):
                if error == .decodingFailed {
                }
            }
        }
    }

    private func fetchList() {
        guard let endpoint = Endpoint.list.url else {
            return
        }

        let urlRequest = URLRequest(url: endpoint)

        networkManager.perform(urlRequest, for: ListCurrencyResponse.self) { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let list):
                self.lastListResponse = list
                self.hasConnection = true
            case .failure(let error):
                if error == .decodingFailed {
                    self.hasConnection = false
                }
            }
        }
    }

    //- MARK: Refresh
    /// Refreshes both the data and cache.
    /// Call this function if you want to invalidate the cache or
    /// get the most up to date data from `NetworkManager`.
    func refresh() {
        fetchList()
        fetchLive()
    }

    //- MARK: Conversion
    /// Converts an amount from one currency to another.
    /// - Parameter amount: The amount to be converted.
    private func convert(_ amount: String) -> String {
        guard let amountDouble = Double(amount) else {
            return ""
        }

        if toCurrencyStorage == "USD" {
            return convertToUSD(amountDouble)
        }

        if fromCurrencyStorage == "USD" {
            return convertFromUSD(amountDouble)
        }

        guard let fromCurrencyUSDValue = quotes[fromCurrencyStorage] else {
            return ""
        }

        guard let toCurrencyUSDValue = quotes[toCurrencyStorage] else {
            return ""
        }

        let fromCurrencyToUSD = fromCurrencyUSDValue

        let converted =  (toCurrencyUSDValue/fromCurrencyToUSD) * amountDouble

        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = toCurrencyStorage
        numberFormatter.numberStyle = .currencyISOCode

        return numberFormatter.string(from: NSNumber(value: converted)) ?? ""
    }

    /// Converts an amount to `USD`.
    private func convertToUSD(_ amount: Double) -> String {
        guard let usdValue = quotes[fromCurrencyStorage] else {
            return ""
        }
        let converted = amount * usdValue

        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = toCurrencyStorage
        numberFormatter.numberStyle = .currencyISOCode

        return numberFormatter.string(from: NSNumber(value: converted)) ?? ""
    }

    /// Converts an amount from `USD`.
    private func convertFromUSD(_ amount: Double) -> String {
        guard let usdValue = quotes[toCurrencyStorage] else {
            return ""
        }
        let currencyValue = 1/usdValue
        let converted = amount * currencyValue

        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = toCurrencyStorage
        numberFormatter.numberStyle = .currencyISOCode

        return numberFormatter.string(from: NSNumber(value: converted)) ?? ""
    }

    /// Trimms the keys for the quotes.
    private func trimmedQuotes(_ quotes: Quotes) -> Quotes {
        var trimmedQuotes = [String: Double]()
        for key in quotes.keys {
            var trimmedKey = key
            trimmedKey.removeFirst(3)
            trimmedQuotes[trimmedKey] = quotes[key]
        }
        return trimmedQuotes
    }

    // - MARK: Cache
    /// Caches the response from `NetworkManager`.
    private func cacheResponse() {
        guard let liveResponse = lastLiveResponse else {
            return
        }

        networkCache.cache(liveResponse, for: LiveCurrencyReponse.self) { (error) in
            if error != nil {

            } else {

            }
        }

        guard let listResponse = lastListResponse else {
            return
        }

        networkCache.cache(listResponse, for: ListCurrencyResponse.self) { (error) in
            if error != nil {

            } else {

            }
        }
    }

}
