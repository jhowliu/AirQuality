//
//  CellForSearch.swift
//  AQI
//
//  Created by jhow on 11/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//

import UIKit

class CellForSearch: UITableViewCell {
    var node: Node? {
        didSet {
            nameLabel.text = (node?.city ?? "") + " " + (node?.district ?? "" )
            airLevelLabel.text = "空氣品質指數: " + (node?.aqi ?? "")
            let levelColor: UIColor = {
                let convertedInt: Int = Int(node?.aqi ?? "-1") ?? -1
                switch (convertedInt) {
                case 0...50:
                    return AirLevel.Good
                case 51...100:
                    return AirLevel.Moderate
                case 101...150:
                    return AirLevel.NotGood
                case 151...200:
                    return AirLevel.Unhealthy
                case 201...300:
                    return AirLevel.VeryUnhealthy
                case 301...999:
                    return AirLevel.Toxic
                default:
                    return UIColor.black
                }
            }()
        
            airLevelLabel.textColor = levelColor
        }
    }
    
    var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
        nameLabel.textColor = .white
        
        return nameLabel
    }()
    
    var airLevelLabel: UILabel = {
        let air = UILabel()
        air.translatesAutoresizingMaskIntoConstraints = false
        air.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightLight)
        air.text = "空氣品質指數: "
        
        return air
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(nameLabel)
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        addSubview(airLevelLabel)
        airLevelLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        airLevelLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
