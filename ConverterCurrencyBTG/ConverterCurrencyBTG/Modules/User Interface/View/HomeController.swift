//
//  HomeController.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 30/06/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    let imageViewTo: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.width / 2
        return imageView
    }()
    
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
        view.addSubview(imageViewTo)
        view.addSubview(titleTo)
        NSLayoutConstraint.activate([
            imageViewTo.widthAnchor.constraint(equalToConstant: 50),
            imageViewTo.heightAnchor.constraint(equalToConstant: 50),
            imageViewTo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageViewTo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTo.topAnchor.constraint(equalTo: imageViewTo.bottomAnchor, constant: 8),
            titleTo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8),
            titleTo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8)
        ])
       
    }
}

extension HomeController: HomePresenterOutput {
    
    func converted(sum: String) {
        print(sum)
    }
    
    func load(toViewModel: HomeViewModel, fromViewModel: HomeViewModel) {
        imageViewTo.image = toViewModel.imageView
        titleTo.text = toViewModel.name
        presenter.send(toCurrency: toViewModel.currency, fromCurrency: fromViewModel.currency, amount: 4)
    }
}

