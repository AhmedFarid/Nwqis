//
//  downCategourysVC.swift
//  Nwqis
//
//  Created by Farido on 12/16/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import HPGradientLoading

class downCategourysVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var categors = [categoriesModel]()
    
    var delegate: FilterDeleget?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        Spiner.addSpiner(isEnableDismiss: false, isBulurBackgroud: true, isBlurLoadin: true, durationAnimation: 1.5, fontSize: 20)
        handleRefreshgetCat()
    }
    
    @objc private func handleRefreshgetCat() {
        HPGradientLoading.shared.configation.fromColor = .white
               HPGradientLoading.shared.configation.toColor = .blue
               HPGradientLoading.shared.showLoading(with: "Loading...")
        API_CategoursAndSubCategours.getAllCategours(search: "", Url:URLs.categories){(error: Error?, categors: [categoriesModel]?,suceess) in
            if let categors = categors {
                self.categors = categors
                print("xxx\(self.categors)")
                self.tableView.reloadData()
            }
            HPGradientLoading.shared.dismiss()
        }
    }
}


extension downCategourysVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? categoryCell {
            let cat = categors[indexPath.row]
            cell.configuerCell(prodect: cat)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return categoryCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = categors[indexPath.row]
        delegate?.filterValueSelected(value: cell.id)
        dismiss(animated: true)
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
