//
//  HTTPProvider.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 12/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

class HTTPProvider<Router: HTTPRouter> {
    func endpoint(router: Router) -> URLRequest? {
        var url = router.baseUrl
        url.appendPathComponent(router.path)
        print(url)
        return nil
    }
    
    func request(router: Router) {
        let request = endpoint(router: router)
    }
}
