//
//  CellForDetail.swift
//  AirQuialityIndex
//
//  Created by jhow on 18/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//
import UIKit

class ViewForDetail: UIView {
    var node: Node? {
        didSet {
            self.aqiLabel.text = node?.aqi
            self.statusLabel.text = node?.status
            self.pollutionView.node = node
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
            aqiLabel.textColor = levelColor
            statusLabel.textColor = levelColor
        }
    }
    
    private let aqiLabel: UILabel = {
        let aqi = UILabel()
        aqi.translatesAutoresizingMaskIntoConstraints = false
        aqi.font = .systemFont(ofSize: 108, weight: UIFontWeightLight)
        aqi.textAlignment = .center
        
        return aqi
    }()
    
    
    private let separatorLine: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        
        return line
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 48, weight: UIFontWeightHeavy)
        label.textAlignment = .center
        
        return label
    }()
    
    private let pollutionView: PollutionView = {
        let view = PollutionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        addSubview(aqiLabel)
        aqiLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        aqiLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        
        
        addSubview(statusLabel)
        statusLabel.topAnchor.constraint(equalTo: aqiLabel.bottomAnchor, constant: 20).isActive = true
        statusLabel.centerXAnchor.constraint(equalTo: aqiLabel.centerXAnchor).isActive = true
        
        addSubview(separatorLine)
        separatorLine.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        separatorLine.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 30).isActive = true
        separatorLine.widthAnchor.constraint(equalToConstant: self.bounds.width-24).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        
        addSubview(pollutionView)
        pollutionView.topAnchor.constraint(equalTo: separatorLine.topAnchor, constant: 45).isActive = true
        pollutionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pollutionView.widthAnchor.constraint(equalToConstant: self.bounds.width - 80).isActive = true
        pollutionView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
