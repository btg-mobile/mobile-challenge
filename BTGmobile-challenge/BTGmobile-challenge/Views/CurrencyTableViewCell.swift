//
//  CurrencyTableViewCell.swift
//  BTGmobile-challenge
//
//  Created by Cassia Aparecida Barbosa on 07/10/20.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
	
	@TemplateView  private var initials: UILabel
	
	@TemplateView private var name: UILabel
	
	static var id: String {
	   return String(describing: self)
	}
	
	
	func addViews() {
		self.addSubview(initials)
		self.addSubview(name)
	}
	
	func addContraintsToLabels() {
		NSLayoutConstraint.activate([
			initials.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
			
			initials.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
			
			initials.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
			
			initials.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			
			initials.widthAnchor.constraint(equalToConstant: self.frame.width * 0.1),


			name.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),

			name.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),

			name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
			
			name.leadingAnchor.constraint(equalTo: self.initials.trailingAnchor, constant: 10),

			name.centerYAnchor.constraint(equalTo: self.centerYAnchor)
			
		])
	}
	
	func setupCellContent(initials: String, name: String) {
		self.initials.text = initials
		self.initials.textColor = .black
		self.name.text = name
		self.name.textColor = .black
	}
	
}
