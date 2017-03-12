//
//  CustomMapViewController.swift
//  AQI
//
//  Created by jhow on 09/03/2017.
//  Copyright © 2017 meowdev.tw. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CustomMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var queue = DispatchQueue(label: "com.meowdev.tw")
    
    // Observer Property
    var mapView: MKMapView? {
        didSet {
            mapView?.delegate = self
            mapView?.mapType = .standard
            mapView?.showsUserLocation = true
        }
    }
    
    var locationManager: CLLocationManager? {
        didSet {
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyKilometer
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFiles()
        setupLocationManager()
        setupMapConfiguration()
        setupNavgationStyle()
        setupAnnotations()
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.requestLocation()
    }
    
    private func setupAnnotations() {
        
        guard let stations = GlobalInstances.nodes else {
            print("Annotation cannot create: because the nodes are nil.")
            return
        }
        
        // refactor soon
        for station in stations {
            let districtName: String = station.district
            let cityName: String = station.city
            let aqi: String = station.aqi
            
            let coordinate: [String: Double] = GlobalInstances.locations[districtName]!
            
            let latitude: Double = coordinate["latitude"] ?? 0.0
            let longtitude: Double = coordinate["longtitude"] ?? 0.0
            
            let annotation = Spot(title: districtName, subtitle: cityName, latitude: latitude, longtitude: longtitude, aqi: aqi)
            mapView?.addAnnotation(annotation)
        }
        mapView?.showAnnotations(mapView?.annotations ?? [], animated: true)
    }
    
    private func setupNavgationStyle() {
        navigationItem.title = "空氣品質指數"
        navigationController?.navigationBar.barTintColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 0.8)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.isTranslucent = true
        setupNavigationButtons()
    }
    
    private func setupNavigationButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "target"), style: .plain, target: self, action: #selector(handleTargetPressed))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    private func loadFiles() {
        guard let url = Bundle.main.url(forResource: "coordinates", withExtension: "json") else { return }
        guard let data = try? Data(contentsOf: url) else { return }

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let dict = json as? [String: [String: Double]] else { return }
            GlobalInstances.locations = dict
        } catch let jsonError {
            print ("failed to parse json: ", jsonError)
        }
    }
    
    private func setupMapConfiguration() {
        mapView = MKMapView(frame: view.frame)
        view.addSubview(mapView!)
    }
    
    private func addAnnotations(annotations: [MKAnnotation]) {
        mapView?.addAnnotations(annotations)
    }
    
    private func removeAnnotations() {
        mapView?.removeAnnotations(mapView?.annotations ?? [])
    }
    
    private func centerTheLocation(coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView?.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("fail to locate the location: ", error)
    }
    /*
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("Hello")
        centerTheLocation(coordinate: userLocation.coordinate)
    }
    */
   
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        // AnyHashtable is as same as NSObject in Objective-C
        let visibleSet = mapView.annotations(in: mapView.visibleMapRect)
        let unVisibleSet = mapView.annotations(in: MKMapRectWorld).subtracting(visibleSet)
        
        queue.async {
            for obj in visibleSet {
                let annotation = obj as! MKAnnotation
                mapView.view(for: annotation)?.isHidden = false
            }
        }
       
        queue.async {
            for obj in unVisibleSet {
                let annotation = obj as! MKAnnotation
                mapView.view(for: annotation)?.isHidden = true
            }
        }
    }
    
    func handleTargetPressed() {
        locationManager?.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        centerTheLocation(coordinate: location.coordinate)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // the annotation for user (the blue circle)
        if annotation is MKUserLocation { return nil }
        
        var view: MKAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.AnnotationViewReuseIdentifier)
        
        if view == nil {
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: Constants.AnnotationViewReuseIdentifier)
            view?.canShowCallout = true
            
            let spot = annotation as! Spot
            let textLabel = UILabel()
            textLabel.frame = CGRect(x: 0, y: 0, width: 45, height: 40)
            textLabel.text = spot.aqi
            textLabel.textColor = .darkGray
            textLabel.textAlignment = .center
            textLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightUltraLight)
     
            let aqi: Int = Int(spot.aqi) ?? -1
            switch (aqi) {
            case 0...50:
                view?.image = #imageLiteral(resourceName: "pin_green")
            case 51...100:
                view?.image = #imageLiteral(resourceName: "pin_yellow")
            case 101...150:
                view?.image = #imageLiteral(resourceName: "pin_orange")
            case 151...200:
                view?.image = #imageLiteral(resourceName: "pin_red")
            case 201...300:
                view?.image = #imageLiteral(resourceName: "pin_purple")
            case 301...999:
                view?.image = #imageLiteral(resourceName: "pin_brown")
            default:
                view?.image = nil
            }
            view?.addSubview(textLabel)
            view?.frame = textLabel.frame // very important
        }
        
        return view
    }
    
    struct Constants {
        static let AnnotationViewReuseIdentifier = "viewId"
    }
}
