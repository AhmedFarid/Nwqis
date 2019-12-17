//
//  homeVC.swift
//  Nwqis
//
//  Created by Farido on 11/21/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
//import MapKit
//import CoreLocation
import HPGradientLoading

class homeVC: UIViewController {
    
    var percent: CGFloat = 0
    var timer: Timer? = Timer()
    
    @IBOutlet weak var chooseArea: roundedTF!
    @IBOutlet weak var chooseLocation: roundedTF!
    @IBOutlet weak var notCatLabel: UILabel!
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var searchTF: roundedTF!
//    @IBOutlet weak var curentLocationOUT: UIButton!
    
    //let locationManager = CLLocationManager()
    var cityId = 0
    var statusID = 0
    var city = [citysModel]()
    var status = [statesModel]()
    var categors = [categoriesModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageText()
        searchTF.delegate = self
        tabelView.delegate = self
        tabelView.dataSource = self
        //locationManager.delegate = self
        notCatLabel.isHidden = true
        searchTF.clearButtonMode = .always
        createCityPiker()

        //getMyLocation()
        Spiner.addSpiner(isEnableDismiss: false, isBulurBackgroud: true, isBlurLoadin: true, durationAnimation: 1.5, fontSize: 20)
        setUpNavColore()
        handleRefreshgetCat(Url: URLs.categories, serchText: "")
        
        
    }
    
    @objc private func handleRefreshgetcity() {
           API_CityAndAreas.getAllCity{(error: Error?, city: [citysModel]?) in
               if let city = city {
                   self.city = city
                   print("xxx\(self.city)")
                   self.textEnabeld()
               }
           }
       }
       
       
       @objc private func handleRefreshgetStates() {
           API_CityAndAreas.getAllStates(city_id: cityId){(error: Error?, status: [statesModel]?) in
               if let status = status {
                   self.status = status
                   print("xxx\(self.status)")
                   self.textEnabeld()
               }
           }
       }
       
       func createToolbar() {
           
           let toolBar = UIToolbar()
           toolBar.sizeToFit()
           
           //Customizations
           toolBar.barTintColor = .black
           toolBar.tintColor = .white
           
           let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(registerVC.dismissKeyboard))
           
           toolBar.setItems([doneButton], animated: false)
           toolBar.isUserInteractionEnabled = true
           
           chooseLocation.inputAccessoryView = toolBar
           chooseArea.inputAccessoryView = toolBar
           
       }
       
       @objc func dismissKeyboard() {
           view.endEditing(true)
       }
       
       
       func textEnabeld() {
           
           if city.isEmpty == true {
               chooseLocation.isEnabled = false
           }else {
               chooseLocation.isEnabled = true
           }
           
           if status.isEmpty == true {
               chooseArea.isEnabled = false
           }else{
               chooseArea.isEnabled = true
           }
       }
       
       func createCityPiker(){
           let citys = UIPickerView()
           citys.delegate = self
           citys.dataSource = self
           citys.tag = 0
           chooseLocation.inputView = citys
           handleRefreshgetcity()
           citys.reloadAllComponents()
       }
       
       func createStatusPiker(){
           let stauts = UIPickerView()
           stauts.delegate = self
           stauts.dataSource = self
           stauts.tag = 1
           chooseArea.inputView = stauts
           handleRefreshgetStates()
           stauts.reloadAllComponents()
       }
       
       
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? subCatVC{
            if let sub = sender as? categoriesModel{
                destaiantion.singleItem = sub
            }
            destaiantion.city_id = cityId
            destaiantion.state_id = statusID
        }else if let destaiantion = segue.destination as? searchVC {
            if let sub = sender as? categoriesModel {
                destaiantion.singelItems = sub
            }
            destaiantion.city_id = cityId
            destaiantion.state_id = statusID
        }
    }
    
    @objc private func handleRefreshgetCat(Url:String,serchText: String) {
        HPGradientLoading.shared.configation.fromColor = .white
               HPGradientLoading.shared.configation.toColor = .blue
               HPGradientLoading.shared.showLoading(with: "Loading...")
        API_CategoursAndSubCategours.getAllCategours(search: serchText, Url:Url){(error: Error?, categors: [categoriesModel]?,suceess) in
            if let categors = categors {
                self.categors = categors
                print("xxx\(self.categors)")
                self.tabelView.reloadData()
            }
            HPGradientLoading.shared.dismiss()
            
            if categors?.count == 0 {
                self.tabelView.isHidden = true
                self.notCatLabel.isHidden = false
            }else {
                self.tabelView.isHidden = false
                self.notCatLabel.isHidden = true
            }
        }
    }
    
    
    func setUpNavColore(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        if helperAddress.getAddresss().area != nil {
//            self.curentLocationOUT.setTitle("\(helperAddress.getAddresss().streetAddresss ?? "") \(helperAddress.getAddresss().area ?? "") ", for: .normal)
//        }else {
//            self.curentLocationOUT.setTitle("Add Location ", for: .normal)
//        }
//    }
    
//    func convertLatLongToAddress(latitude:Double,longitude:Double){
//        let location = CLLocation(latitude: latitude, longitude: longitude)
//        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
//            if error != nil {
//                HPGradientLoading.shared.dismiss()
//                self.showAlert(title: "Error", message: "Error to get your location")
//                return
//            }
//            if (placemarks?.count)! > 0 {
//                let pm = placemarks?[0] as CLPlacemark?
//                helperAddress.saveNewAddress(city: pm?.administrativeArea ?? "", area: pm?.locality ?? "", zone: pm?.subLocality ?? "", streetAddresss: "\(pm?.subThoroughfare ?? "") \(pm?.thoroughfare ?? "")", lat: "\(latitude)", long: "\(longitude)")
//                print("\(String(describing: helperAddress.getAddresss().area))\(helperAddress.getAddresss().city ?? "")\(helperAddress.getAddresss().lat ?? "")")
//                self.curentLocationOUT.setTitle("\(pm?.subThoroughfare ?? "") \(pm?.thoroughfare ?? "") \(pm?.locality ?? "") \(pm?.country ?? "") ", for: .normal)
//                HPGradientLoading.shared.dismiss()
//            }else {
//                print("error2")
//            }
//        })
//    }
//
//
//    func getMyLocation(){
//        HPGradientLoading.shared.configation.fromColor = .white
//        HPGradientLoading.shared.configation.toColor = .blue
//        HPGradientLoading.shared.showLoading(with: "Loading...")
//        self.locationManager.requestAlwaysAuthorization()
//        self.locationManager.requestWhenInUseAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
//            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            self.locationManager.startUpdatingLocation()
//        }
//        //
//    }
    
    func imageText() {
        if let myImage = UIImage(named: "icon_search"){
            searchTF.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: #colorLiteral(red: 0, green: 0.3333333333, blue: 1, alpha: 1))
        }
    }
    
//    @IBAction func getMyLocation(_ sender: Any) {
//        let actionSheetController = UIAlertController(title: "Select Location", message: nil, preferredStyle: .actionSheet)
//
//
//        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
//        }
//        actionSheetController.addAction(cancelActionButton)
//
//        let currentLocationActionButton = UIAlertAction(title: "Current location", style: .default) { action -> Void in
//
//            self.getMyLocation()
//        }
//        actionSheetController.addAction(currentLocationActionButton)
//
//        let addAnAddressActionButton = UIAlertAction(title: "Add an address", style: .default) { action -> Void in
//            self.performSegue(withIdentifier: "suge2", sender: nil)
//        }
//        actionSheetController.addAction(addAnAddressActionButton)
//
//        self.present(actionSheetController, animated: true, completion: nil)
//
//    }
}

extension homeVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? categoryCell {
            let cat = categors[indexPath.row]
            cell.configuerCell(prodect: cat)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return categoryCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard chooseArea.text?.isEmpty == false else{
            showAlert(title: "Error", message: "choose area please")
            return
        }
        let cell = categors[indexPath.row]
        if cell.count_subcategoires == 0{
            self.performSegue(withIdentifier: "suge3", sender: categors[indexPath.row])
        }else {
            self.performSegue(withIdentifier: "suge", sender: categors[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categors.count
        
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


//extension homeVC: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//        convertLatLongToAddress(latitude: locValue.latitude, longitude: locValue.longitude)
//        self.locationManager.stopUpdatingLocation()
//    }
//}


extension homeVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard searchTF.text?.isEmpty == true else {
            handleRefreshgetCat(Url: URLs.searchCategory, serchText: searchTF.text ?? "")
            return false
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
          handleRefreshgetCat(Url: URLs.categories, serchText: searchTF.text ?? "")
            
      return true
    }
}

extension homeVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView.tag == 0{
            return 1
        }else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            return city.count
        }else {
            return status.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0{
            return city[row].name
        }else{
            return status[row].name
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0{
            chooseLocation.text = city[row].name
            cityId = city[row].id
            createStatusPiker()
            //self.view.endEditing(false)
        }else {
            chooseArea.text = status[row].name
            statusID = status[row].id
        }
        
    }
}
