//
//  .swift
//  AQI
//
//  Created by jhow on 07/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//

import UIKit

protocol CellViewDelegate: class {
    func cellViewDidSwipe()
    func deleteDidPressed(node: Node)
}

class CellForCollectionView: UICollectionViewCell {
    
    weak var delegate: CellViewDelegate?
    
    var data: Node? {
        didSet {
            let text = (data?.city)! + " - " + (data?.district)!
            city.text = text
            pm2dot5.text = data?.pm2_5
            lastUpdateLabel.text = "最後更新: " + (data?.updatedTime ?? "")
            statusLabel.text = data?.status
            aqiLabel.text = data?.aqi
            let levelColor: UIColor = {
                let convertedInt: Int = Int(data?.aqi ?? "-1") ?? -1
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
    
    private let city: UILabel = {
        let city = UILabel()
        city.translatesAutoresizingMaskIntoConstraints = false
        city.font = .systemFont(ofSize: 20, weight: UIFontWeightLight)
        city.text = "高雄市 - 鳳山"
        city.textColor = .white
        //city.backgroundColor = .black
        
        return city
    }()
    
    private let pm2dot5: UILabel = {
        let pm = UILabel()
        pm.translatesAutoresizingMaskIntoConstraints = false
        //pm.backgroundColor = .blue
        //pm.text = "PM2.5     10"
       
        return pm
    }()
    
    private let aqiLabel: UILabel = {
        let aqi = UILabel()
        aqi.translatesAutoresizingMaskIntoConstraints = false
        aqi.textAlignment = .center
        aqi.text = "155"
        aqi.font = .systemFont(ofSize: 55, weight: UIFontWeightLight)
        return aqi
    }()
    
    private let aqiBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        
        return view
    }()
   
    private let seperatorLine: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .black
        
        return line
    }()
    
    private let background: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    private let statusLabel: UILabel = {
        let status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.font = .systemFont(ofSize: 14, weight: UIFontWeightHeavy)
        //status.backgroundColor = .white
        status.textAlignment = .center
        status.text = "對所有族群不良"
        
        return status
    }()
    
    private let lastUpdateLabel: UILabel = {
        let last = UILabel()
        last.translatesAutoresizingMaskIntoConstraints = false
        last.text = "最後更新: 2017-03-07 17:00"
        last.font = .systemFont(ofSize: 9, weight: UIFontWeightLight)
        //last.backgroundColor = .white
        
        return last
    }()
    
    private let deleteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
        btn.tintColor = .red
        
        return btn
    }()
   
    private let toolView: UIView = {
        let toolView = UIView()
        toolView.translatesAutoresizingMaskIntoConstraints = false
        toolView.backgroundColor = .red
        toolView.layer.cornerRadius = 5
        toolView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        
        return toolView
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        // tool view
        addSubview(toolView)
        toolView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: self.bounds.width/4*3).isActive = true
        toolView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        toolView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        toolView.widthAnchor.constraint(equalToConstant: self.bounds.width/4).isActive = true
        
        toolView.addSubview(deleteButton)
        
        deleteButton.centerXAnchor.constraint(equalTo: toolView.centerXAnchor).isActive = true
        deleteButton.centerYAnchor.constraint(equalTo: toolView.centerYAnchor).isActive = true
       
        // data view
        addSubview(background)
        background.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        background.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        background.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        background.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        background.addSubview(lastUpdateLabel)
        lastUpdateLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 2).isActive = true
        lastUpdateLabel.rightAnchor.constraint(equalTo: background.rightAnchor, constant: -5).isActive = true
        lastUpdateLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        background.addSubview(aqiBackground)
        aqiBackground.leftAnchor.constraint(equalTo: background.leftAnchor , constant: 30).isActive = true
        aqiBackground.topAnchor.constraint(equalTo: background.topAnchor, constant: 10).isActive = true
        aqiBackground.widthAnchor.constraint(equalToConstant: 60).isActive = true
        aqiBackground.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        background.addSubview(city)
        city.leftAnchor.constraint(equalTo: aqiBackground.rightAnchor, constant: 25).isActive = true
        city.centerYAnchor.constraint(equalTo: aqiBackground.centerYAnchor, constant: 0).isActive = true
        city.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        background.addSubview(seperatorLine)
        seperatorLine.leftAnchor.constraint(equalTo: aqiBackground.rightAnchor, constant: 20).isActive = true
        seperatorLine.rightAnchor.constraint(equalTo: background.rightAnchor, constant: -5).isActive = true
        seperatorLine.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 2).isActive = true
        seperatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        background.addSubview(aqiLabel)
        aqiLabel.centerXAnchor.constraint(equalTo: aqiBackground.centerXAnchor).isActive = true
        aqiLabel.centerYAnchor.constraint(equalTo: aqiBackground.centerYAnchor).isActive = true
        aqiLabel.widthAnchor.constraint(equalToConstant: 50)
        aqiLabel.heightAnchor.constraint(equalToConstant: 50)
        
        background.addSubview(statusLabel)
        statusLabel.topAnchor.constraint(equalTo: aqiBackground.bottomAnchor, constant: 0).isActive = true
        statusLabel.centerXAnchor.constraint(equalTo: aqiBackground.centerXAnchor, constant: 0).isActive = true
        statusLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(viewDidSwipe))
        leftSwipe.direction = .left
        background.addGestureRecognizer(leftSwipe)
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(viewDidSwipe))
        background.addGestureRecognizer(rightSwipe)
        
        deleteButton.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
    }
    
    enum Direction {
        case Right
        case Left
    }
    
    func deletePressed() {
        print("Button Touch")
        guard let node = data else { return }
        delegate?.deleteDidPressed(node: node)
    }
    
    func viewDidSwipe(recognizer: UISwipeGestureRecognizer) {
        switch recognizer.direction {
            
        case UISwipeGestureRecognizerDirection.left:
            if background.center.x <= bounds.width/4 { return }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.background.center.x -= (self.bounds.width/4)
                self.toolView.center.x -= (self.bounds.width/8*3 + 4) // 4 is a pendding
            })
        default:
            if background.center.x >= bounds.width/2 { return }
            UIView.animate(withDuration: 0.3, animations: {
                self.background.center.x += (self.bounds.width/4)
                self.toolView.center.x += (self.bounds.width/8*3 + 4)
            })
        }
        delegate?.cellViewDidSwipe()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
