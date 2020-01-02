//
//  profileVC.swift
//  Nwqis
//  Created by Farido on 12/15/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import HPGradientLoading
//import FittedSheetsPod


class profileVC: UIViewController {
    
    @IBOutlet weak var filterBTN: UIButton!
    @IBOutlet weak var emailLb: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var offersLabel: UILabel!
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var myRequestsTabelView: UITableView!
    
    var offers = [offersModel]()
    var myRequest = [myRequests]()
    var singleItem: categoriesModel?
    var email = ""
    var phone = ""
    var name = ""
    var catId = 0
    var cityId = 0
    var statsID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offersLabel.isHidden = true
        handleRefreshgetProfile()
        handleRefreshgetGetMyRequests()
        filterBTN.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        myRequestsTabelView.delegate = self
        myRequestsTabelView.dataSource = self
        tableView.isHidden = true
        Spiner.addSpiner(isEnableDismiss: false, isBulurBackgroud: true, isBlurLoadin: true, durationAnimation: 1.5, fontSize: 20)
        setupSegment()
    }
    
    
    func setupSegment(){
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        //segmentView.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentView.setTitleTextAttributes(titleTextAttributes, for: .selected)
        segmentView.layer.cornerRadius = segmentView.bounds.height / 2
        segmentView.layer.borderWidth = 3
        segmentView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentView.clipsToBounds = true
        segmentView.layer.masksToBounds = true
        
        if #available(iOS 13.0, *) {
            segmentView.selectedSegmentTintColor = #colorLiteral(red: 0.09394007176, green: 0.2400603294, blue: 0.4907802343, alpha: 1)
            segmentView.layer.cornerRadius = segmentView.bounds.height / 2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handleRefreshgetProfile()
        //handleRefreshgetOffers(category_id: "")
    }
    
    @IBAction func settingBTN(_ sender: Any) {
        print("1111111\(catId)")
        performSegue(withIdentifier: "suge", sender: nil)
    }
    
    
    @objc private func handleRefreshgetOffers(category_id: String) {
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading(with: "Loading...")
        API_Prfoile.getOffers(category_id: "\(category_id)"){(error: Error?, offers: [offersModel]?,suceess) in
            if let offers = offers {
                self.offers = offers
                print("xxx\(self.offers)")
                self.tableView.reloadData()
            }
            if offers?.count == 0 {
                self.tableView.isHidden = true
                self.offersLabel.isHidden = false
            }else {
                self.tableView.isHidden = false
                self.offersLabel.isHidden = true
            }
            HPGradientLoading.shared.dismiss()
        }
    }
    
    
    @objc private func handleRefreshgetGetMyRequests() {
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading(with: "Loading...")
        API_Requests.getMyRequests{(error: Error?, myRequest: [myRequests]?,suceess) in
            if let myRequest = myRequest {
                self.myRequest = myRequest
                print("xxx\(self.myRequest)")
                self.myRequestsTabelView.reloadData()
            }
            if myRequest?.count == 0 {
                self.myRequestsTabelView.isHidden = true
                self.offersLabel.isHidden = false
                self.offersLabel.text = "No Requests"
            }else {
                self.myRequestsTabelView.isHidden = false
                self.offersLabel.isHidden = true
            }
            HPGradientLoading.shared.dismiss()
        }
    }
    
    @IBAction func showCatBTn(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tableView") as! downCategourysVC
        let navigationController = UINavigationController(rootViewController: vc)
        vc.delegate = self
        self.present(navigationController, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentView.selectedSegmentIndex {
        case 0:
            filterBTN.isHidden = true
            tableView.isHidden = true
            handleRefreshgetGetMyRequests()
        case 1:
            filterBTN.isHidden = false
            tableView.isHidden = false
            myRequestsTabelView.isHidden = true
            handleRefreshgetOffers(category_id: "")
        default:
            break;
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? editProifleVC{
            destaiantion.email = email
            destaiantion.fullName = name
            destaiantion.phone = phone
            destaiantion.cittid = cityId
            destaiantion.statId = statsID
        }else if let destaiantion = segue.destination as? myRequestsDitelsVC {
            if let sub = sender as? myRequests{
                destaiantion.singleItem = sub
            }
        }
    }
    
    @objc private func handleRefreshgetProfile() {
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading(with: "Loading...")
        
        API_Prfoile.getMyProfile{(error: Error?,successConnction,success,full_name,email,phone,city_id,state_id) in
            if success == true {
                self.emailLb.text = email
                self.nameLb.text = full_name
                self.email = email ?? ""
                self.phone = phone ?? ""
                self.name = full_name ?? ""
                self.cityId = city_id ?? 0
                self.statsID = state_id ?? 0
                print(state_id ?? 0)
            }else {
                self.showAlert(title: "Internet Connection", message: "check internet connection")
            }
            HPGradientLoading.shared.dismiss()
        }
    }
}

extension profileVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? offersCell {
                let cat = offers[indexPath.row]
                cell.configuerCell(prodect: cat)
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                return cell
            }else {
                return offersCell()
            }
        }else{
            if let cell = myRequestsTabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? myRequestsCell {
                let cat = myRequest[indexPath.row]
                cell.configuerCell(prodect: cat)
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                return cell
            }else {
                return myRequestsCell()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 0 {
            print("x")
        }else {
            performSegue(withIdentifier: "suge2", sender: myRequest[indexPath.row])
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0{
            return offers.count
        }else {
            return myRequest.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 10))
        view.backgroundColor = .clear
        return view
    }
}

extension profileVC: FilterDeleget{
    func filterValueSelected(value: Int) {
        handleRefreshgetOffers(category_id: "\(value)")
    }
}
