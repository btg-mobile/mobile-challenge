//
//  ConvertViewModel.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 30/04/21.
//

import Foundation
import PKHUD

class ConvertViewModel {
    
    private var repository: ConvertRepositoryDelegate = ConvertRepository()
    private var viewDelegate: ConvertControllerDelegate?
    
    private var quotes: [QuoteModel] = []
    public var type: CurrencyTypeView?
    private var fromModel: CountryCurrencyModel?
    private var toModel: CountryCurrencyModel?
    private var message: MessageDeletate = Message()
    
    func bindData() {
        HUD.show(.progress)
        repository.getQuotes { (response) in
            let result = try! response.get()
            self.quotes = result.getQuotes()
            HUD.hide()
        }
    }
    
    func convert(value: Double) {
        guard let fromModel = self.fromModel, let toModel = self.toModel else {
            message.showError(message: "Necessário informar a origem e destino da conversão!")
            return
        }
        
        guard !quotes.isEmpty else {
            message.showError(message: "Nenhum cota identificada. Tente novamente mais tarde!")
            return
        }
        
        SupportConverter(quotes: quotes, value: value, fromRef: fromModel.completeRef, toRef: toModel.completeRef).convert { (value) in
            self.viewDelegate?.showResult(result: value)
        }
    }
    
    // MARK: - Utils
    
    func set(type: CurrencyTypeView) {
        self.type = type
    }
    
    func set(model: CountryCurrencyModel) {
        guard type == CurrencyTypeView.from else {
            self.toModel = model
            return
        }
        self.fromModel = model
    }
    
    func set(delegate: ConvertControllerDelegate) {
        self.viewDelegate = delegate
    }
    
}
