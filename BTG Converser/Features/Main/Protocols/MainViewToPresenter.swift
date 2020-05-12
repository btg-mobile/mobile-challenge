//
//  MainViewToPresenter.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

protocol MainViewToPresenter: class {

    var valueToConverter: String? { get }

    func showWarningFailToUpdate(with lastUpdateDate: String)
    func showErrorFailToUpdate()

    func showSuccessState()

    func toggleEnableSourceTextField(to status: Bool)
    func toggleEnableConverterButton(to status: Bool)
    func updateFromCode(_ code: String)
    func updateToValue(_ value: String)

    func showError(with keyMessage: String)

}
