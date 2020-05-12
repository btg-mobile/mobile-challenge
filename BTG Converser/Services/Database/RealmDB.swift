//
//  RealmDB.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import RealmSwift

final class RealmDB {

    static func configRealm() {
        let config = Realm.Configuration(
            schemaVersion: 0,
            migrationBlock: { _, _ in }
        )

        Realm.Configuration.defaultConfiguration = config

        let realmDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint("Realm file directory: \(realmDirectory)")

        _ = try! Realm()
    }

}
