//
//  DataTable.swift
//  AQI
//
//  Created by jhow on 07/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//

import UIKit

class Node {
    var city: String
    var aqi: String
    var pm2_5: String
    var pm10: String
    var o3: String
    var co: String
    var no2: String
    var so2: String
    var status: String
    var district: String
    var updatedTime: String
   
    init(data: [String: Any]) {
        self.city = data["County"] as? String ?? ""
        self.district = data["SiteName"] as? String ?? ""
        self.pm2_5 = data["PM2.5"] as! String == "" ? "0" : data["PM2.5"] as! String
        self.pm10 = data["PM10"] as! String == "" ? "0" : data["PM10"] as! String
        self.o3 = data["O3"] as! String == "" ? "0" : data["O3"] as! String
        self.co = data["CO"] as! String == "" ? "0" : data["CO"] as! String
        self.no2 = data["NO2"] as! String == "0" ? "0" : data["NO2"] as! String
        self.so2 = data["SO2"] as! String == "0" ? "0" : data["SO2"] as! String
        self.aqi = data["AQI"] as? String ?? ""
        self.status = data["Status"] as? String ?? ""
        self.updatedTime = data["PublishTime"] as? String ?? ""
    }
    
    func toDicitonaries() -> [String: String] {
        var dictionaries = [String: String]()
   
        dictionaries["County"] = self.city
        dictionaries["SiteName"] = self.district
        dictionaries["PM2.5"] = self.pm2_5
        dictionaries["PM10"] = self.pm10
        dictionaries["O3"] = self.o3
        dictionaries["CO"] = self.co
        dictionaries["NO2"] = self.no2
        dictionaries["SO2"] = self.so2
        dictionaries["AQI"] = self.aqi
        dictionaries["Status"] = self.status
        dictionaries["PublishTime"] = self.updatedTime
        
        return dictionaries
    }
   
    // Use for search
    func isEqual(node: Node) -> Bool {
        return node.district == self.district
    }
}

struct GlobalInstances {
    static var nodes: [Node]?
    // coordinates
    static var locations = [String: [String: Double]]()
    
}
struct AirLevel {
    static let Toxic = UIColor.brown
    static let VeryUnhealthy = UIColor.purple
    static let Unhealthy = UIColor(red: 1, green: 0, blue: 0, alpha: 0.7)
    static let NotGood = UIColor.orange
    static let Moderate = UIColor.yellow
    static let Good = UIColor.green
}
    

