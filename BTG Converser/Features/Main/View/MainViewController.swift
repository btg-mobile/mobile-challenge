//
//  MainViewController.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var toButton: UIButton!

    @IBOutlet weak var sourceTextField: UITextField!
    @IBOutlet weak var sourceCode: UILabel!

    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    @IBOutlet weak var lastUpdateLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!

    private lazy var presenter: MainPresenterToView = {
        return MainPresenter(view: self)
    }()

    private let segueToFromListIdentifier = "toFromList"
    private let segueToToListIdentifier = "toToList"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }

    private func updateDataTapped() {
        DispatchQueue.main.async { [weak self] in
            self?.fromButton.isEnabled = false
            self?.toButton.isEnabled = false
            self?.sourceTextField.isEnabled = false
            self?.convertButton.isEnabled = false

            self?.updateButton.isHidden = true

            self?.lastUpdateLabel.text = "Updating data"

            self?.loadingIndicator.startAnimating()
            self?.presenter.updateDataTapped()
        }
    }

    private func showEnableState(lastUpdateDate: String) {
        DispatchQueue.main.async { [weak self] in
            self?.fromButton.isEnabled = true
            self?.toButton.isEnabled = true


            self?.updateButton.isHidden = false

            self?.lastUpdateLabel.text = "Last update: \(lastUpdateDate)"

            self?.loadingIndicator.stopAnimating()
        }
    }

    @IBAction func updateButtonTapped(_ sender: Any) {
        self.updateDataTapped()
    }

    @IBAction func convertButtonTapped(_ sender: Any) {
        self.presenter.convertButtonTapped()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case self.segueToFromListIdentifier: self.prepareFromList(segue.destination)
        case self.segueToToListIdentifier: self.prepareToList(segue.destination)
        default: break
        }
    }

    private func prepareFromList(_ destination: UIViewController?) {
        guard let viewController = destination as? ListViewController else { return }
        self.presenter.currentEditing = .from
        viewController.currentCode = self.presenter.currentFromCode
        viewController.delegate = self
    }

    private func prepareToList(_ destination: UIViewController?) {
        guard let viewController = destination as? ListViewController else { return }
        self.presenter.currentEditing = .to
        viewController.currentCode = self.presenter.currentToCode
        viewController.delegate = self
    }
}

// MARK: - MainViewToPresenter

extension MainViewController: MainViewToPresenter {

    var valueToConverter: String? {
        self.sourceTextField.text
    }

    func showWarningFailToUpdate(with lastUpdateDate: String) {
        self.showEnableState(lastUpdateDate: lastUpdateDate)

        DispatchQueue.main.async { [weak self] in
            self?.updateButton.setTitle("failed to update, try again", for: .normal)
        }
    }

    func showErrorFailToUpdate() {
        let alertController = UIAlertController(
            title: "Error on fetch currencies and taxes",
            message: "Check your internet connection and try again", preferredStyle: .alert)

        let tryAgainButton = UIAlertAction(title: "try again", style: .default) { [weak self] _ in
            self?.updateDataTapped()
        }

        alertController.addAction(tryAgainButton)

        DispatchQueue.main.async { [weak self] in
            self?.loadingIndicator.stopAnimating()
            self?.present(alertController, animated: true)
        }
    }

    func showSuccessState() {
        self.showEnableState(lastUpdateDate: "now")
        DispatchQueue.main.async { [weak self] in
            self?.updateButton.setTitle("update again", for: .normal)
        }
    }

    func toggleEnableSourceTextField(to status: Bool) {
        DispatchQueue.main.async {
            self.sourceTextField.isEnabled = status
        }
    }

    func toggleEnableConverterButton(to status: Bool) {
        DispatchQueue.main.async {
            self.convertButton.isEnabled = status
        }
    }

    func updateFromCode(_ code: String) {
        self.sourceCode.text = code
        self.sourceTextField.placeholder = "0.00"
    }

    func updateToValue(_ value: String) {
        self.destinationLabel.text = value
    }

    func showError(with keyMessage: String) {
        let alertController = UIAlertController(
            title: NSLocalizedString("main.error.title", comment: "Convert error title") ,
            message: NSLocalizedString(keyMessage, comment: "Convert error message"),
            preferredStyle: .alert
        )

        let closeButton = UIAlertAction(title: "close", style: .default)

        alertController.addAction(closeButton)

        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true)
        }
    }

}

extension MainViewController: ListDelegate {

    func didSelectCode(_ code: String) {
        self.presenter.didSelectCode(code)
    }

}
