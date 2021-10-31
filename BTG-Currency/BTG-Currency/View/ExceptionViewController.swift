//
//  ExceptionViewController.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 30/10/21.
//

import UIKit

class ExceptionViewController: UIViewController, Storyboarded {
    
    var error: ServiceError?
    
    @IBOutlet weak var imageError: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageError.image = error?.image
        descriptionLabel.text = error?.localizedDescription
    }
}
