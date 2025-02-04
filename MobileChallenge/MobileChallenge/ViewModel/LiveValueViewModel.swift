//
//  LiveValueViewModel.swift
//  MobileChallenge
//
//  Created by Gabriel Vicentin Negro on 18/11/24.
//

import Foundation
import Combine

class LiveValueViewModel {
    
    @Published var loading: Bool = false
    @Published var selectedFromCurrency: String = "USD"
    @Published var selectedToCurrency = "BRL"
    @Published var liveValuesList: [String:Double] = [:]
    
    private var cancellables = Set<AnyCancellable>()
    
    func getLiveValues() {
        guard let url = URL(string: "https://raw.githubusercontent.com/Banking-iOS/mock-interview/main/api/live.json") else {
            print("URL Inválida")
            return
        }
        
        self.loading = true
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: LiveValue.self, decoder: JSONDecoder())
            .map { $0.quotes }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.loading = false
                if case .failure(let error) = completion {
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] listOfQuotes in
                self?.liveValuesList = listOfQuotes
            })
            .store(in: &cancellables)
    }
    
    func updateSelectedCurrencyFrom(selectedFromCurrency: String) {
        self.selectedFromCurrency = selectedFromCurrency
    }

    func updateSelectedCurrencyTo(selectedToCurrency: String) {
        self.selectedToCurrency = selectedToCurrency
    }
    
    func calculate(originalValue: Double, multiplier: Double) -> String {
        return String(format: "%.2f", ceil((originalValue)*(multiplier)*100)/100)
    }
    
}
