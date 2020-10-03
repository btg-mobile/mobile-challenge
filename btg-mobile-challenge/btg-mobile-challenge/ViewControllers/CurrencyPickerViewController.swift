//
//  CurrencyPickerViewController.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 02/10/20.
//

import UIKit

/// Representation of the app's currency picking screen.
final class CurrencyPickerViewController: UIViewController {
    // - MARK: Properties

    /// Representation of supported currencies.
    @AutoLayout private var currencyTableView: UITableView

    /// The `ViewModel` for this type.
    private let viewModel: CurrencyPickerViewModel

    //- MARK: Init
    /// Initializes a new instance of this type.
    /// - Parameter viewModel: The `ViewModel` for this type.
    init(viewModel: CurrencyPickerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //- MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationItem()
        setUpViewModel()
        setUpViews()
        layoutConstraints()
    }

    @objc private func cancelSelection() {
        dismiss(animated: true, completion: nil)
    }

    //- MARK: ViewModel setup
    private func setUpViewModel() {
        viewModel.delegate = self
        title = viewModel.title
    }

    // - MARK: Views setup
    private func setUpViews() {
        view.backgroundColor = .systemBackground
        currencyTableView.backgroundColor = .systemBackground
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
    }

    private func setUpNavigationItem() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                         target: self,
                                         action: #selector(cancelSelection))
        navigationItem.rightBarButtonItem = cancelButton
    }

    // - Layout
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

// - MARK: UITableViewDelegate
extension CurrencyPickerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.currentCurrency = indexPath
        dismiss(animated: true, completion: nil)
    }

}

//- MARK: UITableViewDataSource
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

//- MARK: ViewModel delegate
extension CurrencyPickerViewController: CurrencyListViewModelDelegate {
    func didSelectCurrency(_ indexPath: IndexPath, previous: IndexPath) {
        currencyTableView.reloadRows(at: [indexPath, previous], with: .fade)
    }
}
