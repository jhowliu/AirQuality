//
//  CustomTabBarController.swift
//  AQI
//
//  Created by jhow on 08/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        viewControllers = []
        
        setupTabBarItems()
    }
    
    func setupTabBarItems() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //  change the space between the cell
        layout.minimumLineSpacing = -5
        let firstNavController = CustomNavController(rootViewController: CustomCollectionViewController(collectionViewLayout: layout))
        firstNavController.title = "首頁"
        firstNavController.tabBarItem.image = #imageLiteral(resourceName: "home")
       
        let secNavController = CustomNavController(rootViewController: CustomMapViewController())
        secNavController.title = "地圖"
        secNavController.tabBarItem.image = #imageLiteral(resourceName: "map")
        
        tabBar.isTranslucent = false
        
        viewControllers = [firstNavController, secNavController]
    }
}
