//
//  Remind.swift
//  FinalProject
//
//  Created by User04 on 2018/6/22.
//  Copyright © 2018年 User04. All rights reserved.
//

import Foundation
import UIKit




struct Remind : Codable {
    var time : String
    var title : String
    var content : String
    
    static func readAccountsFromFile() -> [Remind]? {
        
        let propertyDecoder = PropertyListDecoder()
        if let data = UserDefaults.standard.data(forKey: "reminds"), let reminds = try?
            propertyDecoder.decode([Remind].self, from: data){
            return reminds
        }else{
            return nil
        }
    }
    
    static func saveToFile(reminds: [Remind]){
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(reminds){
            UserDefaults.standard.set(data, forKey: "reminds")
        }
    }
    
}
