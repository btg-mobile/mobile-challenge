//
//  TemplateView.swift
//  BTGmobile-challenge
//
//  Created by Cassia Aparecida Barbosa on 06/10/20.
//

import Foundation
import UIKit

@propertyWrapper final class TemplateView<View: UIView> {
	
	private lazy var view: View = {
		let view = View(frame: .zero)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	var wrappedValue: View {
		return view
	}
}
