//
//  PollutionView.swift
//  AirQuialityIndex
//
//  Created by jhow on 18/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//

import UIKit

class PollutionView: UIView {
    var node: Node? {
        didSet {
            self.pm2_5Label.text = "PM2.5            \((node?.pm2_5)!)"
            self.pm10Label.text =  "PM10              \((node?.pm10)!)"
            self.o3Label.text =    "臭氧               \((node?.o3)!)"
            self.coLabel.text =    "一氧化碳       \((node?.co)!)"
            self.no2Label.text =   "二氧化氮       \((node?.no2)!)"
            self.so2Label.text =   "二氧化硫       \((node?.so2)!)"
        }
    }
    
    private lazy var pm2_5Label = PollutionView.duplicatedLabel()
    private lazy var pm10Label = PollutionView.duplicatedLabel()
    private lazy var o3Label  = PollutionView.duplicatedLabel()
    private lazy var coLabel  = PollutionView.duplicatedLabel()
    private lazy var no2Label = PollutionView.duplicatedLabel()
    private lazy var so2Label = PollutionView.duplicatedLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(pm2_5Label)
        pm2_5Label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        pm2_5Label.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        pm2_5Label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        pm2_5Label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        
        addSubview(pm10Label)
        pm10Label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        pm10Label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        pm10Label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        pm10Label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        
        addSubview(o3Label)
        o3Label.centerXAnchor.constraint(equalTo: pm2_5Label.centerXAnchor).isActive = true
        o3Label.topAnchor.constraint(equalTo: pm2_5Label.bottomAnchor).isActive = true
        o3Label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        o3Label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        
        addSubview(coLabel)
        coLabel.centerXAnchor.constraint(equalTo: pm10Label.centerXAnchor).isActive = true
        coLabel.topAnchor.constraint(equalTo: pm10Label.bottomAnchor).isActive = true
        coLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        coLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        
        addSubview(no2Label)
        no2Label.centerXAnchor.constraint(equalTo: o3Label.centerXAnchor).isActive = true
        no2Label.topAnchor.constraint(equalTo: o3Label.bottomAnchor).isActive = true
        no2Label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        no2Label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
        
        addSubview(so2Label)
        so2Label.centerXAnchor.constraint(equalTo: coLabel.centerXAnchor).isActive = true
        so2Label.topAnchor.constraint(equalTo: coLabel.bottomAnchor).isActive = true
        so2Label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        so2Label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    static func duplicatedLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(white: 0.9, alpha: 0.9)
        label.font = .systemFont(ofSize: 18, weight: UIFontWeightLight)
        label.textAlignment = .center
        label.layer.borderWidth = 0.5
        label.layer.cornerRadius = 10
        
        return label
    }
}
