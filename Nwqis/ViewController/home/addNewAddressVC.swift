//
//  addNewAddressVC.swift
//  Nwqis
//
//  Created by Farido on 11/25/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol HandleMapSearch: class {
    func dropPinZoomIn(_ placemark:MKPlacemark)
}


class addNewAddressVC: UIViewController {
    
    var selectedPin: MKPlacemark?
    var resultSearchController: UISearchController!
    
    
    @IBOutlet weak var zoneTF: roundedTF!
    @IBOutlet weak var areaTF: roundedTF!
    @IBOutlet weak var addressString: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var cityTF: roundedTF!
    @IBOutlet weak var streetAdressTF: roundedTF!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 500
    var previousLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         checkLocationServices()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = map
        locationSearchTable.handleMapSearchDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2588235294, green: 0.4039215686, blue: 0.6980392157, alpha: 1)
        setUpNavColore(false)
        
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            map.setRegion(region, animated: true)
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTackingUserLocation()
        case .denied:
            showAlert(title: "Location", message: "Allow location")
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            showAlert(title: "Location", message: "Allow location")
            break
        case .authorizedAlways:
            startTackingUserLocation()
        @unknown default:
            break
        }
    }
    
    
     func startTackingUserLocation() {
           map.showsUserLocation = false
           centerViewOnUserLocation()
           locationManager.startUpdatingLocation()
           previousLocation = getCenterLocation(for: map)
       }
    
    
   func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
   func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            showAlert(title: "Location", message: "turn location on")
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        setUpNavColore(true)
        
    }
    
    func setUpNavColore(_ isTranslucent: Bool){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = map.centerCoordinate.latitude
        let longitude = map.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    
    
    @IBAction func addToListBTN(_ sender: Any) {
        
        guard let city = cityTF.text, !city.isEmpty else {
            let messages = NSLocalizedString("enter your city name", comment: "hhhh")
            let title = NSLocalizedString("Add new address", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let area = areaTF.text, !area.isEmpty else {
            let messages = NSLocalizedString("enter your area name", comment: "hhhh")
            let title = NSLocalizedString("Add new address", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let zone = zoneTF.text, !zone.isEmpty else {
            let messages = NSLocalizedString("enter your zone name", comment: "hhhh")
            let title = NSLocalizedString("Add new address", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let streetAddresss = streetAdressTF.text, !streetAddresss.isEmpty else {
            let messages = NSLocalizedString("enter your street addresss", comment: "hhhh")
            let title = NSLocalizedString("Login Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        
        guard self.map.centerCoordinate.latitude != 0.0 else {
            let messages = NSLocalizedString("please choose your location on map", comment: "hhhh")
            let title = NSLocalizedString("Add new address", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        
        guard self.map.centerCoordinate.longitude != 0.0 else {
            let messages = NSLocalizedString("please choose your location on map", comment: "hhhh")
            let title = NSLocalizedString("Add new address", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        helperAddress.saveNewAddress(city: cityTF.text ?? "", area: areaTF.text ?? "", zone: zoneTF.text ?? "", streetAddresss: streetAdressTF.text ?? "", lat: "\(self.map.centerCoordinate.latitude)", long: "\(self.map.centerCoordinate.longitude)")
        
        
        let alert = UIAlertController(title: "New Address", message: "Success To Add New Address", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,  handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


extension addNewAddressVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}




extension addNewAddressVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            let center = getCenterLocation(for: mapView)
            let geoCoder = CLGeocoder()
            
            guard let previousLocation = self.previousLocation else { return }
            
            guard center.distance(from: previousLocation) > 50 else { return }
            self.previousLocation = center
            
            geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
                guard let self = self else { return }
                
                if let _ = error {
                    //TODO: Show alert informing the user
                    return
                }
                
                guard let placemark = placemarks?.first else {
                    //TODO: Show alert informing the user
                    return
                }
                
                let streetNumber = placemark.subThoroughfare ?? ""
                let streetName = placemark.thoroughfare ?? ""
                let area = placemark.locality ?? ""
                let city = placemark.administrativeArea ?? ""
                let zone = placemark.subLocality ?? ""
                print(area)
                
                DispatchQueue.main.async {
                    self.addressString.text = "\(streetNumber) \(streetName)"
                    self.cityTF.text = "\(city)"
                    self.zoneTF.text = "\(zone)"
                    self.streetAdressTF.text = "  \(streetNumber) \(streetName)"
                    self.areaTF.text = "\(area)"
                    print(self.map.centerCoordinate.latitude)
                    print(self.map.centerCoordinate.longitude)
                }
            }
        }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        guard !(annotation is MKUserLocation) else { return nil }
        
        let reuseId = "pin"
        guard let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView else { return nil }
        
        pinView.pinTintColor = UIColor.orange
        pinView.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        var button: UIButton?
        button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button?.setBackgroundImage(UIImage(named: "car"), for: UIControl.State())
        pinView.leftCalloutAccessoryView = button
        
        return pinView
    }

}

    
extension addNewAddressVC: HandleMapSearch {
    
    func dropPinZoomIn(_ placemark: MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        map.removeAnnotations(map.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
                annotation.subtitle = "\(city) \(state)"
        }
        
        map.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        map.setRegion(region, animated: true)
    }
    
}

    
    
