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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }

    private func updateDataTapped() {
        self.fromButton.isEnabled = false
        self.toButton.isEnabled = false
        self.sourceTextField.isEnabled = false
        self.convertButton.isEnabled = false
        
        self.updateButton.isHidden = true

        self.lastUpdateLabel.text = "Updating data"

        self.loadingIndicator.startAnimating()
        self.presenter.updateDataTapped()
    }

    private func showEnableState(lastUpdateDate: String) {
        self.fromButton.isEnabled = true
        self.toButton.isEnabled = true
        self.sourceTextField.isEnabled = true
        self.convertButton.isEnabled = true

        self.updateButton.isHidden = false

        self.lastUpdateLabel.text = "Last update: \(lastUpdateDate)"

        self.loadingIndicator.stopAnimating()
    }

    @IBAction func updateButtonTapped(_ sender: Any) {
        self.updateDataTapped()
    }

    @IBAction func convertButtonTapped(_ sender: Any) {
        
    }
}

// MARK: - MainViewToPresenter

extension MainViewController: MainViewToPresenter {

    func showWarningFailToUpdate(with lastUpdateDate: String) {
        self.showEnableState(lastUpdateDate: lastUpdateDate)
        self.updateButton.setTitle("failed to update, try again", for: .normal)
    }

    func showErrorFailToUpdate() {
        let alertController = UIAlertController(
            title: "Error on fetch currencies and taxes",
            message: "Check your internet connection and try again", preferredStyle: .alert)

        let tryAgainButton = UIAlertAction(title: "try again", style: .default) { _ in
            self.updateDataTapped()
        }

        alertController.addAction(tryAgainButton)

        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.present(alertController, animated: true)
        }
    }

}