//
//  HomeController.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 30/06/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    let viewTo: CurrencyView = CurrencyView.instanceFromNib()
    let viewFrom: CurrencyView = CurrencyView.instanceFromNib()
    
    let titleTo: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var presenter: HomePresenterInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        presenter.viewDidLoad()
    }
    
    func setupLayout() {
         let gestureTo:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(targetViewDidTappedTo(_:)))
        let gestureFrom:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(targetViewDidTappedFrom(_:)))
        viewTo.translatesAutoresizingMaskIntoConstraints = false
        viewFrom.translatesAutoresizingMaskIntoConstraints = false
        viewTo.tag = 0
        viewFrom.tag = 1
        viewTo.addGestureRecognizer(gestureTo)
        viewFrom.addGestureRecognizer(gestureFrom)
        view.addSubview(viewTo)
        view.addSubview(viewFrom)
        let width = (view.frame.width / 2) - 16
        NSLayoutConstraint.activate([
            viewTo.widthAnchor.constraint(equalToConstant: width),
            viewTo.heightAnchor.constraint(equalToConstant: 100),
            viewTo.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            viewTo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewFrom.topAnchor.constraint(equalTo: viewTo.topAnchor),
            viewFrom.leadingAnchor.constraint(equalTo: viewTo.trailingAnchor, constant: 4),
            viewFrom.heightAnchor.constraint(equalTo: viewTo.heightAnchor),
            viewFrom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 4)
        ])
       
    }
    
    @objc func targetViewDidTappedTo(_ sender: UITapGestureRecognizer) {
        
        
    }
    
    @objc func targetViewDidTappedFrom(_ sender: UITapGestureRecognizer) {
        
    }
}

extension HomeController: HomePresenterOutput {
    
    func converted(sum: String) {}
    
    func load(toViewModel: HomeViewModel, fromViewModel: HomeViewModel) {
        viewTo.configure(viewModel: toViewModel)
        viewFrom.configure(viewModel: fromViewModel)
    }
}

