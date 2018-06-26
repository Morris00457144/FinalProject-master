//
//  Account.swift
//  FinalProject
//
//  Created by User04 on 2018/6/22.
//  Copyright © 2018年 User04. All rights reserved.
//

import Foundation
import UIKit

struct Account : Codable {
    var item : String
    var money : String
    var time : String
    
    
    static func readAccountsFromFile() -> [Account]? {
    
        let propertyDecoder = PropertyListDecoder()
        if let data = UserDefaults.standard.data(forKey: "accounts"), let accounts = try?
            propertyDecoder.decode([Account].self, from: data){
            return accounts
        }else{
            return nil
        }
    }
    
    static func saveToFile(accounts: [Account]){
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(accounts){
            UserDefaults.standard.set(data, forKey: "accounts")
        }
    }
    
}
