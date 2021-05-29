//
//  ConvertViewController.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import UIKit

class ConvertViewController: UIViewController, UIGestureRecognizerDelegate {
    
    ///Coordinator
    weak var coordinator:MainCoordinator?
    
    ///Base View
    let baseView = ConvertView()
    
    ///modelView
    let modelView = ConvertViewModel()
    
    override func loadView() {
        super.loadView()
        self.view = baseView
        self.navigationController?.isNavigationBarHidden  = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Add Triggers
        addTriggers()
        
        //Add Tap Gesture
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapAction))
        gestureRecognizer.delegate = self
        
        baseView.addGestureRecognizer(gestureRecognizer)
    }
}

//MARK: - Gesture Actions
extension ConvertViewController{
    @objc func tapAction() {
        baseView.textInputOrigin.resignFirstResponder()
    }
}

//MARK: - Triggers
extension ConvertViewController{
    
    /**
     addTriggers of buttons
     - Authors: Mateus R.
     - Returns: nothing
     - Parameters nothing
     */
    func addTriggers(){
        baseView.changeButtonOrigin.addTarget(self, action: #selector(self.actionChangeButtonOrigin(_:)), for: .touchUpInside)
        baseView.destinyButtonOrigin.addTarget(self, action: #selector(self.actionDestinyButtonOrigin(_:)), for: .touchUpInside)
        baseView.convertButton.addTarget(self, action: #selector(self.actionConvertButton(_:)), for: .touchUpInside)
    }
}

//MARK: Action of buttons
extension ConvertViewController{
    @objc func actionConvertButton(_ sender: Any){
        do{
            
            let string = baseView.textInputOrigin.text
            let number = Double(string ?? "0")
            
            let result = try modelView.convert(valueForConvertion: number ?? 0.0, nameCurrencyOrigin: baseView.currencyOrigin.text ?? "NOTHING", nameCurrencyDestny: baseView.currencyDestiny.text ?? "NOTHING")
            
            baseView.labelDestiny.text = "\(result)"
            
        }catch{
            if error as! ErrorsConvertViewModel == ErrorsConvertViewModel.inputZero{
                baseView.simpleAlert(viewController: self, "Alerta", "Valor inválido", "OK")
            }
            baseView.simpleAlert(viewController: self, "Alerta", "Escolha a moeda de origem e de destino", "OK")
        }
    }
    
    @objc func actionChangeButtonOrigin(_ sender: Any){
        coordinator?.navigateToCurrencyViewController(destinyData: .currencyOrigin, delegateCurrency: self)
    }
    
    @objc func actionDestinyButtonOrigin(_ sender: Any){
        coordinator?.navigateToCurrencyViewController(destinyData: .currencyDestiny, delegateCurrency: self)
    }
}

//MARK: CurrencyViewControllerDelegate
extension ConvertViewController:CurrencyViewControllerDelegate{
    func notifyChooseCurrencyConvertVC(nameCurrency: String, quote: Double, destiny: CurrencyViewModelDestiny) {
        modelView.configureCurrencyName(nameCurrency, view: baseView, destiny: destiny, quote: quote)
    }
}
