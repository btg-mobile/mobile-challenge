//
//  NetworkMonitor.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 06/02/25.
//

import Foundation
import Network

class NetworkMonitor {
    
    
    // monitora o status da rede
    let monitor = NWPathMonitor()
    var statusMonitor: Bool = false
    
    func checkConnection() -> Bool{
        
        monitor.pathUpdateHandler = { path in // sempre que houver mudanca na conexao sera chamado
            if path.status == .satisfied {
                self.statusMonitor = true
            } else {
                self.statusMonitor = false
            }
            
        }
        // criado para executar o monitoramento em uma thread secundaria
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        return statusMonitor

        
    }
    
}
