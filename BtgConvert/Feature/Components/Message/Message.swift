//
//  Message.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 02/05/21.
//

import Foundation
import PKHUD

protocol MessageDeletate {
    func showError(message: String?)
}

class Message: MessageDeletate {
    func showError(message: String?) {
        guard let message = message else { return }
        HUD.show(.label(message))
        HUD.hide(afterDelay: TimeInterval.init(1), completion: nil)
    }
    static func showError(message: String?) {
        guard let message = message else { return }
        HUD.show(.label(message))
        HUD.hide(afterDelay: TimeInterval.init(1), completion: nil)
    }
}
