//
//  AppDataBase.swift
//  mobile-challenge
//
//  Created by Kivia on 5/3/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import Foundation
import SQLite3


class AppDataBase {
  
  var db: OpaquePointer?
  
  // MARK: Init
  
  init() {
    createDataBase()
  }
  
  func createDataBase() {
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
      .appendingPathComponent("mobile-challenge.sqlite")
    
    if sqlite3_open(fileURL.path,&db) != SQLITE_OK {
      print("error opening database")
    }
    
    if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS CurrencyEntity (id INTEGER PRIMARY KEY AUTOINCREMENT, currencyCode TEXT, currencyName TEXT)", nil, nil, nil) != SQLITE_OK {
      let errmsg = String(cString: sqlite3_errmsg(db)!)
      print("error creating table: \(errmsg)")
    }
    
    if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS QuoteEntity (id INTEGER PRIMARY KEY AUTOINCREMENT, _from TEXT, _to TEXT, _value REAL)", nil, nil, nil) != SQLITE_OK {
      let errmsg = String(cString: sqlite3_errmsg(db)!)
      print("error creating table: \(errmsg)")
    }
    
  }
  
  // MARK: Currency Table
  
  func insertOrUpdateListCurrencyEntityTable(list : [CurrencyEntity]) {
    let actualList = selectAllCurrencyEntityTable()
    list.forEach { (entity) in
      let filter = actualList.first { (quote) -> Bool in
        quote._id == entity._id
      }
      if let currency = filter {
        updateCurrencyEntityTable(newEntity: entity, id: currency._id)
      } else {
        insertCurrencyEntityTable(entity: entity)
      }
    }
  }
  
  func updateCurrencyEntityTable(newEntity: CurrencyEntity, id: Int) {
    print("UPDATE CURRENCY : \(newEntity)")
    var updateStatement: OpaquePointer?
    let updateStatementString =
    "UPDATE CurrencyEntity SET currencyCode = '\(newEntity.currencyCode)', currencyName = '\(newEntity.currencyName)' WHERE id = '\(id)';"
    if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) ==
      SQLITE_OK {
      if sqlite3_step(updateStatement) == SQLITE_DONE {
        print("Successfully updated row.CURRENCY\n")
      } else {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("Could not update row.CURRENCY: \(errmsg)\n")
        insertCurrencyEntityTable(entity: newEntity)
      }
    } else {
      print("UPDATE statement is not prepared\n")
    }
    sqlite3_finalize(updateStatement)
  }
  
  func insertCurrencyEntityTable(entity: CurrencyEntity) {
    print("INSERT CURRENCY : \(entity)")
    let insertStatementString = "INSERT INTO CurrencyEntity (currencyCode, currencyName) VALUES (?,?);"
    var insertStatement: OpaquePointer?
    if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
      sqlite3_bind_text(insertStatement, 1, NSString(string: entity.currencyCode).utf8String, -1, nil)
      sqlite3_bind_text(insertStatement, 2, NSString(string: entity.currencyName).utf8String, -1, nil)
      if sqlite3_step(insertStatement) == SQLITE_DONE {
        print("Successfully inserted row.CURRENCY\n")
      } else {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("failure inserting currency: \(errmsg)\n")
      }
    } else {
      print("INSERT statement is not prepared.\n")
    }
    sqlite3_finalize(insertStatement)
  }
  
  func selectAllCurrencyEntityTable() -> [CurrencyEntity]{
    var finalList = [] as! [CurrencyEntity]
    let queryStatementString = "SELECT * FROM CurrencyEntity;"
    var queryStatement: OpaquePointer?
    if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
      while (sqlite3_step(queryStatement) == SQLITE_ROW) {
        let id = sqlite3_column_int(queryStatement, 0)
        
        guard let queryResultCol1 = sqlite3_column_text(queryStatement, 1) else {
          print("Query result is nil code\n")
          return finalList
        }
        let currencyCode = String(cString: queryResultCol1)
        
        guard let queryResultCol2 = sqlite3_column_text(queryStatement, 2) else {
          print("Query result is nil name\n")
          return finalList
        }
        let currencyName = String(cString: queryResultCol2)
        finalList.append(CurrencyEntity(Int(id), currencyCode, currencyName))
      }
    } else {
      let errorMessage = String(cString: sqlite3_errmsg(db))
      print("Query is not prepared \(errorMessage)\n")
    }
    sqlite3_finalize(queryStatement)
    print("Query Result CURRENCY: \n \(finalList)\n")
    return finalList
  }
  
  // MARK: Quote Table
  
  func insertOrUpdateListQuoteEntityTable(list : [QuoteEntity]) {
    let actualList = selectAllQuoteEntityTable()
    list.forEach { (entity) in
      let filter = actualList.first { (quote) -> Bool in
        quote._id == entity._id
      }
      if let quote = filter  {
        updateQuoteEntityTable(newEntity: entity, id: quote._id)
      } else {
        insertQuoteEntityTable(entity: entity)
      }
    }
  }
  
  func updateQuoteEntityTable(newEntity: QuoteEntity, id: Int) {
    print("UPDATE QUOTE : \(newEntity)")
    var updateStatement: OpaquePointer?
    let updateStatementString =
    "UPDATE QuoteEntity SET _from = '\(newEntity.from)', _to = '\(newEntity.to)', _value = '\(newEntity.value)' WHERE id = '\(id)';"
    if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) ==
      SQLITE_OK {
      if sqlite3_step(updateStatement) == SQLITE_DONE {
        print("Successfully updated row.QUOTE\n")
      } else {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("Could not update row: \(errmsg)\n")
      }
    } else {
      print("UPDATE statement is not prepared\n")
    }
    sqlite3_finalize(updateStatement)
  }
  
  func insertQuoteEntityTable(entity: QuoteEntity) {
    print("INSERT QUOTE : \(entity)")
    let insertStatementString = "INSERT INTO QuoteEntity (_from, _to, _value) VALUES (?,?,?);"
    var insertStatement: OpaquePointer?
    if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
      sqlite3_bind_text(insertStatement, 1, NSString(string: entity.from).utf8String, -1, nil)
      sqlite3_bind_text(insertStatement, 2, NSString(string: entity.to).utf8String, -1, nil)
      sqlite3_bind_double(insertStatement, 3, entity.value)
      if sqlite3_step(insertStatement) == SQLITE_DONE {
        print("Successfully inserted row.QUOTE\n")
      } else {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("failure inserting quote: \(errmsg)\n")
      }
    } else {
      print("INSERT statement is not prepared.\n")
    }
    sqlite3_finalize(insertStatement)
  }
  
  func selectAllQuoteEntityTable() -> [QuoteEntity]{
    var finalList = [] as! [QuoteEntity]
    let queryStatementString = "SELECT * FROM QuoteEntity;"
    var queryStatement: OpaquePointer?
    if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
      while (sqlite3_step(queryStatement) == SQLITE_ROW) {
        
        let id = sqlite3_column_int(queryStatement, 0)
        
        guard let queryResultCol1 = sqlite3_column_text(queryStatement, 1) else {
          print("Query result is nil from\n")
          return finalList
        }
        let from = String(cString: queryResultCol1)
        
        guard let queryResultCol2 = sqlite3_column_text(queryStatement, 2) else {
          print("Query result is nil to\n")
          return finalList
        }
        let to = String(cString: queryResultCol2)
        
        guard let queryResultCol3 = sqlite3_column_double(queryStatement, 3) as Double? else {
          print("Query result is nil value\n")
          return finalList
        }
        let value = Double(queryResultCol3)
        finalList.append(QuoteEntity(Int(id), from, to, value))
      }
    } else {
      let errorMessage = String(cString: sqlite3_errmsg(db))
      print("Query is not prepared \(errorMessage)\n")
    }
    sqlite3_finalize(queryStatement)
    print("Query Result QUOTE: \n \(finalList)\n")
    return finalList
  }
  
}
