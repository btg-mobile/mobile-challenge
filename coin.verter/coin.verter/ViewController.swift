//
//  ViewController.swift
//  coin.verter
//
//  Created by Caio Berkley on 21/06/20.
//  Copyright © 2020 Caio Berkley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK - Outlets
    @IBOutlet weak var inputCurrencyButton: UIButton!
    @IBOutlet weak var resultCurrencyButton: UIButton!
    @IBOutlet weak var inputCurrencyLabel: UILabel!
    @IBOutlet weak var resultCurrencyLabel: UILabel!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var cleanCurrencyButton: UIButton!
    @IBOutlet weak var pointButton: UIButton!
    @IBOutlet weak var convertCurrencyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func inputCurrencyButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func resultCurrencyButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func helpButtonTapped(_ sender: Any) {
        
        let mensagem = "Deseja contatar o desenvolvedor via WhatsApp?"
        let alert = UIAlertController(title: "Alguma dúvida?", message: mensagem, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Depois", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if (action.style == .default){
                if let url = URL(string: "https://wa.me/5513981953015?text=BTG%20Digital:%20Parab%C3%A9ns!%20Voc%C3%AA%20foi%20selecionado%20para%20a%20vaga%20de%20Desenvolvedor%20iOS!"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url)
                    }
                    else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cleanCurrencyButtonTapped(_ sender: Any) {
        inputCurrencyLabel.text = "0"
        resultCurrencyLabel.text = "0"
    }
    
    @IBAction func convertCurrencyButtonTapped(_ sender: Any) {
        
    }
    
    

}

