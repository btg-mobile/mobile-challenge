//
//  ListService.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import Foundation
import Combine

public class ListService {
    public func fetchList() -> AnyPublisher<[ListItem], Error> {
        Network(Endpoints.list.url)
            .request(ListDTO.self)
            .map({ listDTO in
                listDTO.currencies?.compactMap({ (key: String, value: String) in
                    ListItem(symbol: key, name: value)
                }) ?? []
            })
            .eraseToAnyPublisher()
    }
}
