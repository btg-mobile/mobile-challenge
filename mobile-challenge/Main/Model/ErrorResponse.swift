//
//  ErrorResponse.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import Foundation


struct ErrorResponse {
  
  let success: Bool
  let error: ErrorInfo
  
}

struct ErrorInfo {
  
  let code: Int
  let type: String
  let info: String
  
}
