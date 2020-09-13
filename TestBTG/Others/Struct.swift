//
//  Struct.swift
//  TestBTG
//
//  Created by Renato Kuroe on 13/09/20.
//  Copyright © 2020 Renato Kuroe. All rights reserved.
//

import UIKit

class Struct: NSObject {
    public struct Currency {
        let code: String
        let name: String
    }

    public struct Quote {
          let code: String
          let price: NSNumber
      }
}
