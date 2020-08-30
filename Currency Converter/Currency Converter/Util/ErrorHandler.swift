//
//  ErrorHandler.swift
//  Currency Converter
//
//  Created by Pedro Fonseca on 29/08/20.
//  Copyright © 2020 Pedro Bernils. All rights reserved.
//

import UIKit

extension NSError {
    func parsedErrorForHTTPStatusCode(_ httpStatusCode: Int) -> NSError {
//        switch httpStatusCode {
//        case 401:
//            return NSError(domain: self.domain,
//                           code: 401,
//                           userInfo: [NSLocalizedDescriptionKey: "Unauthorized access",
//                            NSLocalizedRecoverySuggestionErrorKey: "Try loging in again"])
//        case 409:
//            return NSError(domain: self.domain,
//                           code: 409,
//                           userInfo: [NSLocalizedDescriptionKey: "Conflict",
//                            NSLocalizedRecoverySuggestionErrorKey: "Already exists"])
//        case -1009:
//            return NSError(domain: self.domain,
//                           code: -1009,
//                           userInfo: [NSLocalizedDescriptionKey: "No internet connection",
//                            NSLocalizedRecoverySuggestionErrorKey: "Try to find a internet connection"])
//        default:
            return NSError(domain: self.domain,
                           code: httpStatusCode,
                           userInfo: [NSLocalizedDescriptionKey: self.localizedDescription,
                            NSLocalizedRecoverySuggestionErrorKey: self.localizedRecoverySuggestion != nil ? self.localizedRecoverySuggestion!:""])
//        }
        
//        404    User requested a resource which does not exist.
//        101    User did not supply an access key or supplied an invalid access key.
//        103    User requested a non-existent API function.
//        104    User has reached or exceeded his subscription plan's monthly API request allowance.
//        105    The user's current subscription plan does not support the requested API function.
//        106    The user's query did not return any results
//        102    The user's account is not active. User will be prompted to get in touch with Customer Support.
//        201    User entered an invalid Source Currency.
//        202    User entered one or more invalid currency codes.
//        301    User did not specify a date. [historical]
//        302    User entered an invalid date. [historical, convert]
//        401    User entered an invalid "from" property. [convert]
//        402    User entered an invalid "to" property. [convert]
//        403    User entered no or an invalid "amount" property. [convert]
//        501    User did not specify a Time-Frame. [timeframe, convert].
//        502    User entered an invalid "start_date" property. [timeframe, convert].
//        503    User entered an invalid "end_date" property. [timeframe, convert].
//        504    User entered an invalid Time-Frame. [timeframe, convert]
//        505    The Time-Frame specified by the user is too long - exceeding 365 days. [timeframe]
    }
}
