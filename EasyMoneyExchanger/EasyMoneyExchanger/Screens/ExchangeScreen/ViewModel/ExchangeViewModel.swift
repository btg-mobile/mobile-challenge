//
//  ExchangeViewModel.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 09/12/20.
//
import UIKit
import Foundation
import Network

class ExchangeViewModel {

    let coreData: CoreDataManager
    let service: CurrencyLayerAPI

    init(service: CurrencyLayerAPI, coreData: CoreDataManager) {
        self.service = service
        self.coreData = coreData
    }

    // MARK: - Main Methods

    // Run when the application Launch
    func initApplication(tableView: UITableView, viewController: ExchangeViewController) {

        // Initialize Local Data
        self.coreData.getRates(tableView: tableView)

        // Check if has local data stored
        if self.coreData.rateItems!.count > 0 {
            self.loadLocalData(uiTableView: tableView)
        } else {
            self.addLocalData(uiTableView: tableView, viewController: viewController)
        }

        // Load CoreData Items
        self.coreData.getRates(tableView: tableView)
        self.coreData.getSupported(tableView: tableView)
        self.coreData.getExchanges(tableView: tableView)
    }

    // MARK: - Local Data

    func loadLocalData(uiTableView: UITableView) {
        self.coreData.getSupported(tableView: uiTableView)
        self.coreData.getExchanges(tableView: uiTableView)
    }

    func addLocalData(uiTableView: UITableView, viewController: ExchangeViewController) {
        fetchSupportedCurrencies(isUpdating: false, tableView: uiTableView, viewController: viewController)
        fetchRealtimeRates(isUpdating: false, tableView: uiTableView, viewController: viewController)
        self.coreData.addExchanges(tableView: uiTableView, from: "BRL", to: "USD")
        self.coreData.getExchanges(tableView: uiTableView)
    }

    func updateLocalData(uiTableView: UITableView, viewController: ExchangeViewController) {
        self.fetchSupportedCurrencies(isUpdating: true, tableView: uiTableView, viewController: viewController)
        self.fetchRealtimeRates(isUpdating: true, tableView: uiTableView, viewController: viewController)
    }

    // MARK: - Other Methods

    // Loads a modal with a list of all available Currencies
    func showCurrencieModal(currenciesView viewController: ExchangeViewController, viewModel: ExchangeViewModel, selectedButton: String) {

        let modal = UIStoryboard(name: "ExchangeScreenModal", bundle: nil)
        let localViewController: ExchangeModalViewController = (modal.instantiateViewController(withIdentifier: "ExchangeScreenModal") as? ExchangeModalViewController)!
        localViewController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        localViewController.modalTransitionStyle = UIModalTransitionStyle.coverVertical

        // Assign Modal Variables
        localViewController.updateLabels = viewController
        localViewController.selected = selectedButton

        viewController.present(localViewController, animated: true, completion: nil)
    }

    // MARK: - Animations

    // This method rotates a given button 360 degrees
    func rotateButton(updateCurrencyButton: UIButton) {
        // Setup Rotation Animation
        UIView.animate(withDuration: 0.5) { () -> Void in
          updateCurrencyButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }

        UIView.animate(withDuration: 0.5, delay: 0.45, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
          updateCurrencyButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
        }, completion: nil)
    }
}
