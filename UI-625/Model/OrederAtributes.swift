//
//  OrederAtributes.swift
//  UI-625
//
//  Created by nyannyan0328 on 2022/07/31.
//

import SwiftUI
import ActivityKit



struct OrederAtributes: ActivityAttributes {
    struct ContentState : Codable,Hashable{
        
        var status : Status = .received
        
        
    }
    
    var orderNumber : Int
    var orderName : String
}


enum Status: String,CaseIterable,Codable,Equatable{
    case received = "shippingbox.fill"
    case progress = "person.bust"
    case ready = "takeoutbag.and.cup.and.straw.fill"
}
