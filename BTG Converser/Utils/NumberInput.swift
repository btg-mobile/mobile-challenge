//
//  NumberInput.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

final class NumberInput: UITextField {

    override func awakeFromNib() {
        self.delegate = self
    }

}

extension NumberInput: UITextFieldDelegate {

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let text = textField.text else { return false }

        if text.isEmpty {
            return Double(string) != nil
        } else {
            let newText = text + string
            return Double(newText) != nil
        }
   }

}
