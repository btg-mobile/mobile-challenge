//
//  CurrencyPickerViewController.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 02/10/20.
//

import UIKit

final class CurrencyPickerViewController: UIViewController {

    @AutoLayout private var currencyTableView: UITableView

    private let viewModel: CurrencyPickerViewModel

    init(viewModel: CurrencyPickerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewModel()
        setUpViews()
        layoutConstraints()
    }

    private func setUpViewModel() {
        viewModel.delegate = self
        title = viewModel.title
    }

    private func setUpViews() {
        view.backgroundColor = .systemBackground
        currencyTableView.backgroundColor = .systemBackground
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
    }

    private func layoutConstraints() {
        view.addSubview(currencyTableView)

        let safeAreaGuides = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            currencyTableView.centerXAnchor.constraint(equalTo: safeAreaGuides.centerXAnchor),
            currencyTableView.centerYAnchor.constraint(equalTo: safeAreaGuides.centerYAnchor),
            currencyTableView.widthAnchor.constraint(equalTo: safeAreaGuides.widthAnchor),
            currencyTableView.heightAnchor.constraint(equalTo: safeAreaGuides.heightAnchor)
        ])
    }
}

extension CurrencyPickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.currentCurrency = indexPath
        dismiss(animated: true, completion: nil)
    }

}

extension CurrencyPickerViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.accessoryType = .none
        cell.textLabel?.text = viewModel.currencyCodeAt(index: indexPath)
        cell.detailTextLabel?.text = viewModel.nameCodeAt(index: indexPath)
        if indexPath == viewModel.currentCurrency {
            cell.accessoryType = .checkmark
        }
        return cell
    }
}

extension CurrencyPickerViewController: CurrencyListViewModelDelegate {
    func didSelectCurrency(_ indexPath: IndexPath, previous: IndexPath) {
        currencyTableView.reloadRows(at: [indexPath, previous], with: .fade)
    }
}
