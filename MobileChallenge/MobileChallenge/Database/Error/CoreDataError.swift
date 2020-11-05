//
//  CoreDataError.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 05/11/20.
//

import Foundation

enum CoreDataError: Error{
    case invalidCreateData
    case invalidManagedObjectType
    case invalidFetchData
    case invalidSaveData
    case invalidUpdateData
    case invalidDeleteData
    case invalidEntityCast
}
