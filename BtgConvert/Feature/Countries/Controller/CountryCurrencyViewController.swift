//
//  CountryCurrencyViewController.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 30/04/21.
//

import Foundation
import UIKit
import PKHUD

enum CurrencyTypeView {
    case from
    case to
}

class CountryCurrencyViewController: UIViewController {
        
    @IBOutlet weak var countryCurrencyTableView: UITableView!
    @IBOutlet weak var searchCountryBar: UISearchBar!
    
    private var viewModel = CountryCurrencyViewModel()
    private var delegate: CountryCurrencySelectedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureSearchBar()

        viewModel.updatedList = {
            DispatchQueue.main.async {
                self.countryCurrencyTableView.reloadData()
            }
        }
    }
    
    func configureSearchBar() {
        searchCountryBar.setImage(UIImage(named: "search-white"), for: .search, state: .normal)
        searchCountryBar.searchTextField.textColor = UIColor.white
        searchCountryBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Informe o nome do país...",
                                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func set(delegate: CountryCurrencySelectedDelegate){
        self.delegate = delegate
    }
}

extension CountryCurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.CountryCurrencyCell, for: indexPath) as! CountryCurrencyCell
        let cellViewModel = viewModel.cellViewModel(forIndex: indexPath.row)
        cell.configure(viewModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.select(model: viewModel.getItem(forIndex: indexPath.row))
        self.dismiss(animated: true, completion: nil)
    }

}

extension CountryCurrencyViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        HUD.show(.progress)
        self.viewModel.research(text: searchBar.text ?? "")
        self.countryCurrencyTableView.reloadData()
        HUD.hide()
    }
}

class CountryCurrencyCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ref: UILabel!
    
    func configure(viewModel: CellCountryCurrency) {
        self.name.text = viewModel.getName()
        self.ref.text = viewModel.getRef()
    }
}
