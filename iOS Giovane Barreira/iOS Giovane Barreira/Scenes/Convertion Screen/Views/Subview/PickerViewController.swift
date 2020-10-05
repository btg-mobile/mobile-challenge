//
//  PickerViewController.swift
//  iOS Giovane Barreira
//
//  Created by Giovane Barreira on 10/4/20.
//

import UIKit

protocol PickerOriginDataDelegate: class {
    func currencyOriginValue(code: String, value: Double)
}

protocol PickerDestinationDataDelegate: class {
    func currencyDestinationValue(code: String, value: Double)
}

class PickerViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerData: [String] = []
    var quotesBinder: QuotesListBind?
    var viewModel: CurrencyQuoteViewModel?
    weak var pickerOriginDelegate: PickerOriginDataDelegate?
    weak var pickerDestinationDelegate: PickerDestinationDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CurrencyQuoteViewModel()
        viewModel?.viewModelOutputDelegate = self
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        viewModel?.fetchQuotes()
        
    }
    
    func parseToPickerData() {
        quotesBinder?.code?.forEach { code in
            pickerData.append(String(code.suffix(3)))
        }
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerOriginDelegate?.currencyOriginValue(code: pickerData[row],
                                                  value: quotesBinder?.value?[row] ?? 0.0)
        
        pickerDestinationDelegate?.currencyDestinationValue(code: pickerData[row],
                                                            value: quotesBinder?.value?[row] ?? 0.0)
    }
}

extension PickerViewController: ViewModelOutputProtocol {
    func getQuotes(currencyModel: QuotesModel) {
        quotesBinder = QuotesListBind(currencyModel)
        parseToPickerData()
    }
}
