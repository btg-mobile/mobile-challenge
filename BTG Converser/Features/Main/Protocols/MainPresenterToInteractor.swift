//
//  MainPresenterToInteractor.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

protocol MainPresenterToInteractor: class {

    func failToFetchDataInAPI(lastUpdate: Date?)
    func successOnFetchDataInAPI()

    func didConvertValue(_ valueConverted: Double)
    func didFailConverValue()

}
