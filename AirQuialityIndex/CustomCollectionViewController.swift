//
//  ViewController.swift
//  AQI
//
//  Created by jhow on 07/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//

import UIKit
import Alamofire

class CustomCollectionViewController:UICollectionViewController, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var tap: UITapGestureRecognizer!
    
    var filtered: [Node]!
    
    var searchBar: UISearchBar!
    var tableView: UITableView!
    
    var favorNodes: [Node]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        collectionView?.register(theCell.self, forCellWithReuseIdentifier: "cellId")
        
        tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        
        setupNavigationBarStyle()
        setupNavigationButtons()
        
        fetchData()
        
        setupSearchController()
        
        loadUserFavoriteNodes()
    }
    
    func loadUserFavoriteNodes() {
        favorNodes = [Node]()
        
        if let dictionaries = UserDefaults.standard.array(forKey: "FavorNodes") {
            for dict in dictionaries { favorNodes.append(Node(data: dict as! [String : Any])) }
        }
    }
    
    func saveUserFavoriteNodes() {
        var dictionaries = [[String: String]]()
      
        for node in favorNodes { dictionaries.append(node.toDicitonaries()) }
       
        UserDefaults.standard.set(dictionaries, forKey: "FavorNodes")
        UserDefaults.standard.synchronize()
    }
    
    func dismissKeyBoard() {
        self.view.endEditing(true)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBar.center.x -= self.view.bounds.width
        })
    }
    
    func setupSearchController() {
        searchBar = UISearchBar(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 35))
        searchBar.barTintColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1)
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        tableView = UITableView(frame: view.frame)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: -1).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
       
        tableView.layer.cornerRadius = 5
        tableView.layer.borderWidth = 0.5
        
        tableView.backgroundColor = .darkGray
        tableView.separatorColor = .lightGray
        
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.backgroundColor = .darkGray
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellForSearch.self, forCellReuseIdentifier: "cell")
       
        tableView.alpha = 0
        searchBar.alpha = 0
        
        filtered = []
    }
    
    func setupNavigationBarStyle() {
        navigationItem.title = "空氣品質指數"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 0.8)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupNavigationButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddButton))
        navigationItem.rightBarButtonItem?.tintColor = .white
   
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "refresh"), style: .plain, target: self, action: #selector(handleRefreshButton))
    }
   
    func handleAddButton() {
        if self.searchBar.isFirstResponder { return }
        // a tricky solution, beacuase of avoiding the autolayout
        if searchBar.center.x >= 0 {
            searchBar.center.x -= view.bounds.width
            searchBar.alpha = 1
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.searchBar.center.x += self.view.bounds.width
            self.searchBar.becomeFirstResponder()
        })
    }
    
    func handleRefreshButton() {
        fetchData()
        navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    func hideOrShow() {
        switch (filtered.count) {
        case 0:
            tableView.alpha = 0
        default:
            tableView.alpha = 0.9
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // Clear up
        collectionView?.removeGestureRecognizer(tap)
        searchBar.text = ""
        filtered.removeAll()
        hideOrShow()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        collectionView?.addGestureRecognizer(tap)
    }
    
    // Search Bar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let nodes = GlobalInstances.nodes else { return }
        
        filtered = nodes.filter({ (node) -> Bool in
            let string = node.city + " " + node.district
            return string.range(of: searchText) != nil
        })
     
        hideOrShow()
        tableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 110)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorNodes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! theCell
        
        let selectedData = favorNodes[indexPath.row]
        cell.data = selectedData
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellForSearch
     
        let node = filtered[indexPath.row]
        
        cell.node = node
        cell.backgroundColor = .darkGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // add node into favorNodes
        DispatchQueue.main.async {
            self.dismissKeyBoard()
            self.collectionView?.reloadData()
        }
        
        let favorNode = filtered[indexPath.row]
        
        if favorNodes.checkIfExist(node: favorNode) != nil { return }
        
        favorNodes.append(favorNode)
        
        saveUserFavoriteNodes()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func fetchData() {
        Alamofire.request("http://opendata.epa.gov.tw/ws/Data/REWIQA/", method: .get, parameters: ["orderby":"County", "format":"json"]).responseJSON(completionHandler: { response in
            
                if let JSON = response.result.value {
                    
                    guard let dictionaries = JSON as? [[String: Any]] else { return }
                    
                    GlobalInstances.nodes = []
                    
                    for dictionary in dictionaries {
                        let node = Node(data: dictionary)
                        GlobalInstances.nodes?.append(node)
                        if let index = self.favorNodes.checkIfExist(node: node) { self.favorNodes[index] = node }
                    }
                    
                    DispatchQueue.main.async {
                        print("Nodes fetch successfully.")
                        self.collectionView?.reloadData()
                        self.navigationItem.leftBarButtonItem?.isEnabled = true
                    }
                }
            })
    }
}

