//
//  CustomTabBarController.swift
//  AQI
//
//  Created by jhow on 08/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        self.delegate = self
        viewControllers = []
        
        setupTabBarItems()
    }
    
    func setupTabBarItems() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //  change the space between the cell
        layout.minimumLineSpacing = -5
        let firstNavController = NavController(rootViewController: CollectionViewController(collectionViewLayout: layout))
        firstNavController.title = "首頁"
        firstNavController.tabBarItem.image = #imageLiteral(resourceName: "home")
       
        let secNavController = NavController(rootViewController: MapViewController())
        secNavController.title = "地圖"
        secNavController.tabBarItem.image = #imageLiteral(resourceName: "map")
        
        tabBar.isTranslucent = false
        
        viewControllers = [firstNavController, secNavController]
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let navController = viewController as! NavController
        
        switch navController.title! {
        case "首頁":
            let home = navController.topViewController as! CollectionViewController
            DispatchQueue.main.async {
                home.collectionView?.reloadData()
            }
        case "地圖":
            let map = navController.topViewController as! MapViewController
            map.refreshAnnotation()
        default:
            return
        }
    }
}
