//
//  LoadingView.swift
//  AirQuialityIndex
//
//  Created by jhow on 18/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    let container: UIView
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.activityIndicatorViewStyle = .gray
        
        return activity
    }()
    
    private let message: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading..."
        label.font = .systemFont(ofSize: 24, weight: UIFontWeightUltraLight)
        
        return label
    }()
    
    private let background: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.8, alpha: 0.7)
        
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        container = UIView(frame: frame)
        container.backgroundColor = UIColor(white: 0, alpha: 0.6)
        super.init(frame: frame)
        
        addSubview(container)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        container.addSubview(background)
        background.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        background.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: -10).isActive = true
        background.heightAnchor.constraint(equalToConstant: 65).isActive = true
        background.widthAnchor.constraint(equalToConstant: 180).isActive = true
        background.layer.cornerRadius = 8
        
        background.addSubview(activityIndicator)
        activityIndicator.leftAnchor.constraint(equalTo: background.leftAnchor, constant: 15).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 25).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        background.addSubview(message)
        message.leftAnchor.constraint(equalTo: activityIndicator.rightAnchor, constant: 15).isActive = true
        message.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
        message.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
