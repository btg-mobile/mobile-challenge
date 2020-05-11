//
//  MainPresenter.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class MainPresenter {

    unowned private let view: MainViewToPresenter

    private lazy var interactor: MainInteractorToPresenter = {
        return MainInteractor(presenter: self)
    }()

    init (view: MainViewToPresenter) {
        self.view = view
    }

    private var fromCode: String?
    private var toCode: String?

    private var editingType = EditingType.from

    private func checkIfSourceInputAndConverterButtonStatus() {
        self.view.toggleEnableSourceTextField(to: self.fromCode != nil)
        self.view.toggleEnableConverterButton(to: self.fromCode != nil && self.toCode != nil)
    }

    private func parseValueToConvert() -> Double? {
        guard let valueToConverter = self.view.valueToConverter else { return nil }
        return Double(valueToConverter)
    }
}

// MARK: - MainPresenterToView

extension MainPresenter: MainPresenterToView {

    var currentEditing: EditingType {
        get {
            self.editingType
        }
        set(newVal) {
            self.editingType = newVal
        }
    }

    var currentFromCode: String? {
        self.fromCode
    }

    var currentToCode: String? {
        self.toCode
    }

    func viewDidLoad() {
        self.interactor.fetchTaxesAndCurrenciesInAPI()
    }

    func updateDataTapped() {
        self.interactor.fetchTaxesAndCurrenciesInAPI()
    }

    func didSelectCode(_ code: String) {
        switch self.editingType {
        case .from:
            self.fromCode = code
            self.view.updateFromCode(code)
        case .to:
            self.toCode = code
            self.view.updateToValue(code)
        }

        self.checkIfSourceInputAndConverterButtonStatus()
    }

    func convertButtonTapped() {
        guard let fromCode = self.fromCode else {
            self.view.showError(with: "main.error.from_code")
            return
        }

        guard let toCode = self.toCode else {
            self.view.showError(with: "main.error.to_code")
            return
        }

        guard let value = self.parseValueToConvert() else {
            self.view.showError(with: "main.error.value")
            return
        }

        self.interactor.convertValue(value, from: fromCode, to: toCode)
    }

}

// MARK: - MainPresenterToInteractor

extension MainPresenter: MainPresenterToInteractor {

    func failToFetchDataInAPI(lastUpdate: Date?) {
        self.checkIfSourceInputAndConverterButtonStatus()

        if let lastUpdate = lastUpdate {
            self.view.showWarningFailToUpdate(with: lastUpdate.parseToString())
        } else {
            self.view.showErrorFailToUpdate()
        }
    }

    func successOnFetchDataInAPI() {
        self.view.showSuccessState()
        self.checkIfSourceInputAndConverterButtonStatus()
    }

    func didConvertValue(_ valueConverted: Double) {
        guard let code = self.toCode else {
            self.view.showError(with: "main.error.convert")
            return
        }

        let valueConvertedString = String(format: "%.3f", valueConverted)
        self.view.updateToValue("\(valueConvertedString) \(code)")
    }

    func didFailConverValue() {
        self.view.showError(with: "main.error.convert")
    }

}
