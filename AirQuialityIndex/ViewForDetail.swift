//
//  CellForDetail.swift
//  AirQuialityIndex
//
//  Created by jhow on 18/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//
import UIKit

class ViewForDetail: UIView {
    
    private let aqiLabel: UILabel = {
        let aqi = UILabel()
        aqi.translatesAutoresizingMaskIntoConstraints = false
        aqi.font = .systemFont(ofSize: 84, weight: UIFontWeightUltraLight)
        aqi.textAlignment = .center
        aqi.text = "155"
        
        return aqi
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: UIFontWeightLight)
        label.textAlignment = .center
        label.text = "高雄"
        
        return label
    }()
    
    private let separatorLine: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .black
        
        return line
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        addSubview(aqiLabel)
        aqiLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        aqiLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        
        addSubview(locationLabel)
        locationLabel.topAnchor.constraint(equalTo: aqiLabel.bottomAnchor, constant: 5).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: aqiLabel.centerXAnchor).isActive = true
        
        addSubview(separatorLine)
        separatorLine.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        separatorLine.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 30).isActive = true
        separatorLine.widthAnchor.constraint(equalToConstant: self.bounds.width-16).isActive = true
        separatorLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
