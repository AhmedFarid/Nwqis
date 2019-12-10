//
//  homeVC.swift
//  Nwqis
//
//  Created by Farido on 11/21/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import HPGradientLoading

class homeVC: UIViewController {
    
    
    
    var percent: CGFloat = 0
    var timer: Timer? = Timer()
    
    
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var searchTF: roundedTF!
    
    @IBOutlet weak var curentLocationOUT: UIButton!
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageText()
        tabelView.delegate = self
        tabelView.dataSource = self
        locationManager.delegate = self
        //getMyLocation()
        addCustomSpinar()
        setUpNavColore()
        
        
    }
    
    
    func setUpNavColore(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if helperAddress.getAddresss().area != nil {
            self.curentLocationOUT.setTitle("\(helperAddress.getAddresss().streetAddresss ?? "") \(helperAddress.getAddresss().area ?? "") ", for: .normal)
        }else {
            self.curentLocationOUT.setTitle("Add Location", for: .normal)
        }
    }
    
    
    func addCustomSpinar(){
        HPGradientLoading.shared.configation.isEnableDismissWhenTap = false
        HPGradientLoading.shared.configation.isBlurBackground = true
        HPGradientLoading.shared.configation.isBlurLoadingActivity = true
        HPGradientLoading.shared.configation.durationAnimation = 1.5
        HPGradientLoading.shared.configation.fontTitleLoading = UIFont.systemFont(ofSize: 20)
    }
    
    
    func convertLatLongToAddress(latitude:Double,longitude:Double){
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                if error != nil {
                    HPGradientLoading.shared.dismiss()
                    self.showAlert(title: "Error", message: "Error to get your location")
                    return
                }
                if (placemarks?.count)! > 0 {
                    let pm = placemarks?[0] as CLPlacemark?
                    helperAddress.saveNewAddress(city: pm?.administrativeArea ?? "", area: pm?.locality ?? "", zone: pm?.subLocality ?? "", streetAddresss: "\(pm?.subThoroughfare ?? "") \(pm?.thoroughfare ?? "")", lat: "\(latitude)", long: "\(longitude)")
                    print("\(String(describing: helperAddress.getAddresss().area))\(helperAddress.getAddresss().city ?? "")\(helperAddress.getAddresss().lat ?? "")")
                    self.curentLocationOUT.setTitle("\(pm?.subThoroughfare ?? "") \(pm?.thoroughfare ?? "") \(pm?.locality ?? "") \(pm?.country ?? "") ", for: .normal)
                    HPGradientLoading.shared.dismiss()
                }else {
                    print("error2")
                }
            })
        }
    
    
    func getMyLocation(){
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading(with: "Loading...")
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
        //
    }
    
    func imageText() {
        if let myImage = UIImage(named: "icon_search"){
            searchTF.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: #colorLiteral(red: 0, green: 0.3333333333, blue: 1, alpha: 1))
        }
    }
    
    @IBAction func getMyLocation(_ sender: Any) {
        let actionSheetController = UIAlertController(title: "Select Location", message: nil, preferredStyle: .actionSheet)
        
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelActionButton)
        
        let currentLocationActionButton = UIAlertAction(title: "Current location", style: .default) { action -> Void in
            
            self.getMyLocation()
        }
        actionSheetController.addAction(currentLocationActionButton)
        
        let addAnAddressActionButton = UIAlertAction(title: "Add an address", style: .default) { action -> Void in
            self.performSegue(withIdentifier: "suge2", sender: nil)
        }
        actionSheetController.addAction(addAnAddressActionButton)
        
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
}

extension homeVC: UITableViewDelegate,UITableViewDataSource {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? categoryCell {
            cell.catBtnClass = {
                self.performSegue(withIdentifier: "suge", sender: nil)
            }
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return categoryCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 10))
        view.backgroundColor = .clear
        return view
    }
}


extension homeVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        convertLatLongToAddress(latitude: locValue.latitude, longitude: locValue.longitude)
        self.locationManager.stopUpdatingLocation()
    }
}
