//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, ResultViewDelegate {
  
  private var rootView : ResultView { return self.view as! ResultView }
  
  // MARK: Init
  
  override func loadView() {
    self.view = ResultView(frame: UIScreen.main.bounds)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    rootView.delegate = self
    configureNavigationBar()
  }
  
  // MARK: Button
  
  func openSelectionViewControler(button: UIButton) {
    print("Button Clicked")
    
    let controller = SelectionViewController()
    self.navigationController?.pushViewController(controller, animated: true)
  }
  
  // Helper Functions
  
  func configureNavigationBar() {
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    self.navigationController?.navigationBar.barTintColor = UIColor(named: "app_primary")
    self.navigationController?.navigationBar.barStyle = .black
    self.navigationController?.navigationBar.tintColor = .white
    let textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold), NSAttributedString.Key.foregroundColor:UIColor.white]
    self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    self.navigationItem.title = "Live Currency"
  }
  
  
}

