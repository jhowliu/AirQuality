//
//  Spot.swift
//  AQI
//
//  Created by jhow on 08/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//

import UIKit
import MapKit

class Spot: NSObject {
    var name: String
    var info: String
    var latitude: Double
    var longtitude: Double
    var imageName: String?
    var aqi: String
    
    init (title: String, subtitle: String, latitude: Double, longtitude: Double, aqi: String, imageName: String? = nil) {
        self.name = title
        self.info = subtitle
        self.latitude = latitude
        self.longtitude = longtitude
        self.imageName = imageName
        self.aqi = aqi
    }
}

extension Spot: MKAnnotation {
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        return info
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
    }
    
    var pinImageName: String {
        return imageName ?? ""
    }
}

