//
//  OSLog.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//
import Foundation
import os.log

extension OSLog {
    private static let subsystem: String = Bundle.main.bundleIdentifier!

    static let networking: OSLog = OSLog(subsystem: subsystem, category: "networking")
    static let appflow: OSLog = OSLog(subsystem: subsystem, category: "appflow")
}
