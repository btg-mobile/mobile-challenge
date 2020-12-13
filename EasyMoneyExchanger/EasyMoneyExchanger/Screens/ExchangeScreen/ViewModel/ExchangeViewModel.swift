//
//  ExchangeViewModel.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 09/12/20.
//
import UIKit
import Foundation

class ExchangeViewModel {

    let coreData: CoreDataManager
    let service: CurrencyLayerAPI

    init(service: CurrencyLayerAPI, coreData: CoreDataManager) {
        self.service = service
        self.coreData = coreData
    }

    // MARK: - Main Methods

    // Run when the application Launch
    func initApplication(tableView: UITableView) {
        // Initialize Local Data
        self.coreData.getRates(tableView: tableView)
        // Check if has local data stored
        if self.coreData.rateItems!.count > 0 {
            loadLocalData(uiTableView: tableView)
        } else {
            addLocalData(uiTableView: tableView)
        }

        coreData.getRates(tableView: tableView)
        coreData.getSupported(tableView: tableView)
        coreData.getExchanges(tableView: tableView)
        print("Init APP")
    }

    func loadLocalData(uiTableView: UITableView) {
        self.coreData.getSupported(tableView: uiTableView)
        self.coreData.getExchanges(tableView: uiTableView)
    }

    func addLocalData(uiTableView: UITableView) {
        fetchSupportedCurrencies(isUpdating: false, tableView: uiTableView)
        fetchRealtimeRates(isUpdating: false, tableView: uiTableView)
        self.coreData.addExchanges(tableView: uiTableView, from: "BRL", to: "USD")
        self.coreData.getExchanges(tableView: uiTableView)
    }

    func updateData(uiTableView: UITableView) {
        fetchSupportedCurrencies(isUpdating: true, tableView: uiTableView)
        fetchRealtimeRates(isUpdating: true, tableView: uiTableView)
    }

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

    // MARK: - Animation
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
