//
//  ViewModelOutput.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 14/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

protocol ViewModelOutput: class {
    func displayLoadingView()
    func hideLoadingView()
}

extension ViewModelOutput {
    func displayLoadingView() {
        BtgLoadingView.start()
    }
    
    func hideLoadingView() {
        BtgLoadingView.stop()
    }
}
