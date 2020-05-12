//
//  MainPresenterToView.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

protocol MainPresenterToView: class {

    var currentEditing: EditingType { get set }
    var currentFromCode: String? { get }
    var currentToCode: String? { get }

    func viewDidLoad()
    func updateDataTapped()
    func didSelectCode(_ code: String)
    func convertButtonTapped()

}
