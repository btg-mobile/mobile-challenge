//
//  UIViewController.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

extension UIViewController {
    /// Remove o teclado da visualização quando clicado fora de sua área...
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// Manda um alerta para o usuário.
    /// - Parameters:
    ///   - title: Descreve o título da alerta.
    ///   - message: Descreve o corpo da menssagem a ser enviada.
    ///   - confirm: Descreve a mensagem do botão de confirmação.
    ///   - completion: Retorna a confimação quando o usuário clicar no botão de confirmação.
    func showAlert(_ title: String,
                   _ message: String = "",
                   _ buttonTitle: String = "Ok",
                   with completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in completion?() })
        alert.addAction(confirm)
        self.present(alert, animated: true, completion: nil)
    }
}
