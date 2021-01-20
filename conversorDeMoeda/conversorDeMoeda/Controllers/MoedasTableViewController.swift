//
//  MoedasTableViewController.swift
//  conversorDeMoeda
//
//  Created by Diogenes de Souza on 08/01/21.
//

import UIKit

class MoedasTableViewController: UITableViewController {
    
    var cambioList: Dictionary<String,String> = [:]
    var moedasList:[Moeda] = []
    var buttonSelect:Int?
    
    @IBOutlet var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //detectar qual linha do tableview é tocada, você precisará definir o delegado no controlador de visualização
        myTableView.delegate = self
    }
    
    //Retorna para a view anterior, botão no final da lista
    @IBAction func returViewAfter(_ sender: Any) {
        fecharView()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //pega no UserDefault o id do botão acionado na tela anterior
        buttonSelect =  UserDefaults.standard.integer(forKey: "buttonSelect")
        
        //Recupera a lista de moedas na API , endPoint "list" (sigla : nome)
        Rest.loadCurrencys(endPoint: "list") { (cambio) in
            self.cambioList = cambio
            
            //percorre o dicionário populando o Array moedasList, para exibir na TableView
            for item in self.cambioList {
                let moeda = Moeda(nome:item.value, sigla:item.key)
                self.moedasList.append(moeda)
            }
            
            //Ordena a lista por nome em ordem crescente
            self.moedasList.sort {
                $0.nome! < $1.nome!
            }
            
            //Atualiza a view na tread maim
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
            
        } onError: { (cambioError) in
            print(cambioError)
        }
        
    }
    
    
    func fecharView(){
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moedasList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        let moeda = moedasList[indexPath.row]
        cell.textLabel?.text = String(moeda.nome!)
        cell.detailTextLabel?.text = String(moeda.sigla!)
        return cell
    }
    // a method from UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sigla:String = moedasList[indexPath.row].sigla ?? ""
        let nome:String = moedasList[indexPath.row].nome ?? ""
        print(sigla)
        
        if self.buttonSelect == 1 {
            UserDefaults.standard.set("\(sigla)-\(nome)" , forKey: "nomeOrig")
            UserDefaults.standard.set(sigla , forKey: "siglaOrig")
        }else{
            UserDefaults.standard.set("\(sigla)-\(nome)"  , forKey: "nomeDest")
            UserDefaults.standard.set(sigla , forKey: "siglaDest")
        }
        
        fecharView()
        
    }
    
}
