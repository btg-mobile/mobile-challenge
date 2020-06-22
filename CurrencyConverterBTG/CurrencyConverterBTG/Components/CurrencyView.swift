//
//  CurrencyView.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 21/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import UIKit

@IBDesignable
class CurrencyView: UIControl {
    
    // MARK: - Properties
    @IBInspectable var imageSize: CGFloat = 48
    
    @IBInspectable var code: String? = nil {
        didSet {
            codeLabel.text = code
        }
    }
    @IBInspectable var name: String? = nil {
        didSet {
            nameLabel.text = name
        }
    }
    @IBInspectable var imageName: String? = nil {
        didSet {
            if let name = imageName, !name.isEmpty {
                configImage(name)
            }
        }
    }
    
    // MARK: - Setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        code = "COD"
        name = "Currency Name"
        imageName = "ico"
    }
    
    private func setup() {
        self.addSubview(stackView)
        let topConstraint = stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor)
        let trailingConstraint = stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        let bottomConstraint = stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        let leadingConstraint = stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
        addConstraints([topConstraint, trailingConstraint, bottomConstraint, leadingConstraint])
        self.isUserInteractionEnabled = true
    }
    
    func config(with viewModel: CurrencyViewModel) {
        self.code = viewModel.code
        self.name = viewModel.name
        self.imageName = viewModel.imageName.lowercased()
    }
    

    // MARK: - Load Image
    private func configImage(_ named: String) {
        guard let image = loadImage(named: named) else { return }
        imageView.image = image
    }

    private func loadImage(named: String) -> UIImage? {
        let bundle = Bundle(for: CurrencyView.self)
        let image = UIImage(named: named, in: bundle, compatibleWith: nil)
        return image
    }
    
    // MARK: - Private Properties
    private lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        var constraints: [NSLayoutConstraint] = []
        constraints.append(imageView.widthAnchor.constraint(equalToConstant: imageSize))
        constraints.append(imageView.heightAnchor.constraint(equalToConstant: imageSize))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addConstraints(constraints)
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    
    // MARK: - Stacks
    private lazy var textStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [codeLabel, nameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isUserInteractionEnabled = false
        return stack
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, textStackView])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isUserInteractionEnabled = false
        return stack
    }()
    
}

