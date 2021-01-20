//
//  ViewController.swift
//  conversorDeMoeda
//
//  Created by Diogenes de Souza on 07/01/21.
//

import UIKit

class ViewController: UIViewController {
    
    var cambioValorList: Dictionary<String,Double> = [:]
    var textOrig:String?
    var textDest:String?
    var siglaOrig:String?
    var siglaDest:String?
    
    @IBOutlet weak var origButton: UIButton!
    @IBOutlet weak var destButton: UIButton!
    @IBOutlet weak var display: UITextField!
    @IBOutlet weak var labelResult: UILabel!
    
    //fechar teclado ao tocar na view
    @IBAction func closeKeyboard(_ sender: Any) {
        labelResult.text = getValorDolar(textOrig: siglaOrig!, textDest: siglaDest!, valor: display.text!)
        self.view.endEditing(true)
    }
    //ação do primeiro botão
    @IBAction func actionOrig(_ sender: UIButton) {
        performSegue(withIdentifier: "next", sender: nil)
        UserDefaults.standard.set(1 , forKey: "buttonSelect")//salva 1 para o botão selecionado em UserDefault
    }
    //ação do segundo botão
    @IBAction func actionDest(_ sender: UIButton) {
        performSegue(withIdentifier: "next", sender: nil)
        UserDefaults.standard.set(2 , forKey: "buttonSelect")//salva 2 para o botão selecionado em UserDefault
    }
    //Atualiza o resultado ao digitar no campo de texto
    @IBAction func updateResult(_ sender: Any) {
        
        if !siglaOrig!.isEmpty &&  !siglaDest!.isEmpty{
            labelResult.text = getValorDolar(textOrig: siglaOrig!, textDest: siglaDest!, valor: display.text!)
          
        }
        
     
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Recupera os dados  do valor e resultado
        if let value = UserDefaults.standard.string(forKey: "display"){
            display.text = value
            }
        if let value = UserDefaults.standard.string(forKey: "result"){
            labelResult.text = value
            }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //recupera dados salvos
        self.textOrig =  UserDefaults.standard.string(forKey: "nomeOrig") ?? "Moeda de Origem"
        self.textDest =  UserDefaults.standard.string(forKey: "nomeDest") ?? "Moeda de destino"
        
        if let origSigla = UserDefaults.standard.string(forKey: "siglaOrig"){
            self.siglaOrig  =  origSigla
        }else{
            self.siglaOrig  =  ""
        }
        
        if let destSigla = UserDefaults.standard.string(forKey: "siglaDest"){
            self.siglaDest  =  destSigla
        }else{
            self.siglaDest  =  ""
        }
        
        
        origButton.setTitle(textOrig, for: .normal)
        destButton.setTitle(textDest, for: .normal)
        
        //Pega a lista de moedas com suas cotações no servidor
        Rest.loadCurrencysValues(endPoint: "live") { (cambio) in
            self.cambioValorList = cambio
        } onError: { (cambioError) in
            print(cambioError)
        }
        //exibe o resultado ao usuário
        
   
        
        if !cambioValorList.isEmpty && !siglaOrig!.isEmpty && !siglaDest!.isEmpty {
            labelResult.text = getValorDolar(textOrig: siglaOrig!, textDest: siglaDest!, valor: display.text!)
        }
       
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        //salvar dados no banco UserDefault, persistencia de dados do app
                UserDefaults.standard.set(display.text, forKey: "display")
        UserDefaults.standard.set(labelResult.text, forKey: "result")
    }

    //faz a conversão da moeda pegando a sigla + "USD", conforme a API e o valor a ser convertido e retorna o resultado
    func getValorDolar(textOrig:String, textDest:String, valor:String) -> String{
        var resultado:Double = 0
        let cotacao1:Double = cambioValorList["USD" + textOrig] ?? 1
        let cotacao2:Double = cambioValorList["USD" + textDest] ?? 1
        
        print("valor em cotaçao 1:\(cotacao1)")
        print("valor em cotacao 2:\(cotacao2)")
        
        //fórmula da conversão :  x= (valor digitado / indice1) * ídice2
        if let valordigitado = Double(valor){
            print("Converteu valor digitado:\(valordigitado)")
            
            let valorEmDolar = valordigitado/cotacao1
            print("valor em dolar: \(valorEmDolar)")
            resultado = valorEmDolar * cotacao2
            print("valor em Destino: \(resultado)")
        }
        
        let resultString = String(resultado)
        
        return resultString
        
    }
    
}

