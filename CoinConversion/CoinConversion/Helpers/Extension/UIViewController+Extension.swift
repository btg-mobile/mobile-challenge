//
//  UIViewController+Extension.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import UIKit

extension UIViewController {
    class var nibName: String {
        return String(describing: self)
    }
    
    
    func configureNavigationBar(largeTitleColor: UIColor,
                                backgoundColor: UIColor,
                                tintColor: UIColor,
                                title: String,
                                preferredLargeTitle: Bool,
                                isSearch: Bool,
                                searchController: UISearchController?
    ) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor:largeTitleColor,
                                                     .font: UIFont.systemFont(ofSize: 25)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: largeTitleColor]
        navBarAppearance.backgroundColor = backgoundColor
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = tintColor
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.title = title
        
        if isSearch && searchController != nil {
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController = searchController
            navigationController?.view.backgroundColor = .white
        }
    }
    
    func topMostViewController() -> UIViewController {
        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }
        
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }
        
        return self
    }
}
