//
//  statusVC.swift
//  Nwqis
//
//  Created by Farido on 1/5/20.
//  Copyright © 2020 Farido. All rights reserved.
//

import UIKit
import HPGradientLoading

class statusVC: UIViewController {
    
    @IBOutlet weak var tabelView: UITableView!
    
    var status = [statesModel]()
    var cityId = 0
    var singlItem: citysModel?
    
    var delegate: addressDeleget?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tabelView.delegate = self
        tabelView.dataSource = self
        
        Spiner.addSpiner(isEnableDismiss: false, isBulurBackgroud: true, isBlurLoadin: true, durationAnimation: 1.5, fontSize: 20)
        
        handleRefreshgetStates()
    }
    
    @objc private func handleRefreshgetStates() {
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading(with: "Loading...")
        API_CityAndAreas.getAllStates(city_id: singlItem?.id ?? 0){(error: Error?, status: [statesModel]?) in
            if let status = status {
                self.status = status
                print("xxx\(self.status)")
                self.tabelView.reloadData()
            }
            HPGradientLoading.shared.dismiss()
        }
    }
}

extension statusVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? stutusCell {
            let cat = status[indexPath.row]
            cell.configuerCell(prodect: cat)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return stutusCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return status.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = status[indexPath.row]
        delegate?.filterValueSelectedAddress(cityId: cell.id,StutsId: singlItem?.id ?? 0, title: "\(singlItem?.name ?? "") \(cell.name)")
        dismiss(animated: true)
    }
}
