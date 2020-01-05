//
//  cityVC.swift
//  Nwqis
//
//  Created by Farido on 1/5/20.
//  Copyright © 2020 Farido. All rights reserved.
//

import UIKit
import HPGradientLoading

class cityVC: UIViewController {
    
    var percent: CGFloat = 0
    var timer: Timer? = Timer()
    
    var city = [citysModel]()
    var delegate: addressDeleget?
    
    @IBOutlet weak var tabelView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelView.delegate = self
        tabelView.dataSource = self
        
        Spiner.addSpiner(isEnableDismiss: false, isBulurBackgroud: true, isBlurLoadin: true, durationAnimation: 1.5, fontSize: 20)
        
        handleRefreshgetcity()
    }
    
    @objc private func handleRefreshgetcity() {
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading(with: "Loading...")
        API_CityAndAreas.getAllCity{(error: Error?, city: [citysModel]?) in
            if let city = city {
                self.city = city
                print("xxx\(self.city)")
                self.tabelView.reloadData()
            }
            HPGradientLoading.shared.dismiss()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? statusVC{
            destaiantion.delegate = delegate
            if let sub = sender as? citysModel{
                destaiantion.singlItem = sub
            }
            
        }
    }
}


extension cityVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CityCell {
            let cat = city[indexPath.row]
            cell.configuerCell(prodect: cat)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return CityCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "suge", sender: city[indexPath.row])
        
        //self.present(navigationController, animated: true, completion: nil)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.count
        
    }
    
}
