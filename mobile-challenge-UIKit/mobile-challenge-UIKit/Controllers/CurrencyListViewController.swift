//
//  CurrencyListViewController.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 18/12/20.
//

import UIKit

class CurrencyListViewController: UIViewController, ViewCodable {

    private weak var coordinator: (MainCoordinator & CurrencyChoosing)?
    private var viewModel: CurrencyListViewModel?
    private let tableViewDataSource = CurrencyListTableViewDataSource()
    private let tableViewDelegate = TableViewDelegate()
    private var onSelectCurrency: (Currency) -> Void = { _ in }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate

        return tableView
    }()

    private lazy var segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl()
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.insertSegment(withTitle: LiteralText.name, at: 0, animated: false)
        segmented.insertSegment(withTitle: LiteralText.code, at: 1, animated: false)
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(onSegmentSelected(_:)), for: .valueChanged)

        return segmented
    }()

    init(coordinator: (MainCoordinator & CurrencyChoosing),
         onSelectCurrency: @escaping (Currency) -> Void) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        self.onSelectCurrency = onSelectCurrency
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setConstraints()
    }

    @objc private func onSegmentSelected(_ segment: UISegmentedControl) {
        viewModel?.sort(by: segment.selectedSegmentIndex)
    }

    func setUp() {
        view.backgroundColor = DesignSystem.Color.background
        navigationItem.title = LiteralText.originViewControllerTitle

        let service = CurrencyListService(network: APIClient.shared)
        viewModel = CurrencyListViewModel(service: service) { [weak self] in
            self?.updateUI()
        }

        guard let viewModel = viewModel else { return }

        tableViewDataSource.setNumberOfRows = {
            return viewModel.currencies.count
        }
        tableViewDataSource.getCurrencyForRowAt = { row in
            return viewModel.currencies[row]
        }

        tableViewDelegate.didSelectRowAt = { [weak self] row in
            self?.onSelectCurrency(viewModel.currencies[row])
            self?.coordinator?.goBack()
        }


    }

    func setConstraints() {
        view.addSubview(segmentedControl)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: DesignSystem.Spacing.default),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: DesignSystem.Spacing.default),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func updateUI() {
        tableView.reloadData()
    }
}
