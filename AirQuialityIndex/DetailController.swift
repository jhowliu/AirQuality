//
//  DetailCell.swift
//  AirQuialityIndex
//
//  Created by jhow on 18/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    var node: Node?
    
    private lazy var detailView: ViewForDetail = {
        let detail = ViewForDetail(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        return detail
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        view.addSubview(detailView)
        detailView.node = node
        
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "\(node?.city ?? "") - \(node?.district ?? "")"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 0.8)
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDoneButton))
    }
    
    func handleDoneButton() {
        dismiss(animated: true, completion: nil)
    }
}
