//
//  textFieldDelegate.swift
//  mobileChallenge
//
//  Created by Henrique on 04/02/25.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate{
    
    var viewmodel: HomeControllerViewModel?
    var onCalculatedValue: ((Double) -> Void)?
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789.").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let num = Double(textField.text!) else {return}
        guard let cal = viewmodel?.calculateConversion(value: num) else { return }
        onCalculatedValue?(cal)
    }
    
    func updateViewModel(viewmodel: HomeControllerViewModel){
        self.viewmodel = viewmodel
    }
}
