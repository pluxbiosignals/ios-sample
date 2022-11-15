//
//  LogMaanger.swift
//  ios-sample
//
//  Created by Gonçalo Telo on 15/11/2022.
//

import Foundation

class LogManager: NSObject {

    // MARK:- Properties
    
    var logLevel: LogLevel
    static let sharedInstance = LogManager()
    
    // MARK:- Lifecycle
    
    override init() {
        
        logLevel = .simple
        super.init()
    }
    
    // MARK:- Public
    
    func log(_ message: String) {
    
        switch self.logLevel {
            
        case .simple:
            let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
            print("[PLUX API Sample \(timestamp)]: \(message)")
            break
        
        case .none: break
        }
    }
}

/* @brief API Log level enumeration
 * case None: Use to disable API logs
 * case Simple: Use to display simple API logs
 */
@objc public enum LogLevel: Int {
    case none = 0
    case simple
}
