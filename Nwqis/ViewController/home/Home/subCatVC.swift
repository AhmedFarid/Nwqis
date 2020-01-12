//
//  subCatVC.swift
//  Nwqis
//
//  Created by Farido on 12/12/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import HPGradientLoading

class subCatVC: UIViewController {
    
    //@IBOutlet weak var loactionBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTF: roundedTF!
    @IBOutlet weak var noCatTF: UILabel!
    
    
    var city_id = 0
    var state_id = 0
    var Subcategor = [SubcategoriesModel]()
    var singleItem: categoriesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTF.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        noCatTF.isHidden = true
        searchTF.clearButtonMode = .always
        Spiner.addSpiner(isEnableDismiss: false, isBulurBackgroud: true, isBlurLoadin: true, durationAnimation: 1.5, fontSize: 20)
        imageText()
        handleRefreshgetCat(url: URLs.subcategories, search: "")
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
    }
    
    
    func imageText() {
        if let myImage = UIImage(named: "icon_search"){
            searchTF.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: #colorLiteral(red: 0, green: 0.3333333333, blue: 1, alpha: 1))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? searchVC{
            if let sub = sender as? SubcategoriesModel{
                destaiantion.singleItem = sub
            }
            destaiantion.city_id = city_id
            destaiantion.state_id = state_id
        }
    }
    
    @objc private func handleRefreshgetCat(url:String,search:String) {
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading(with: "Loading...")
        API_CategoursAndSubCategours.getAllSubCategours(search: search, Url: url, category_id: singleItem?.id ?? 0){(error: Error?, Subcategor: [SubcategoriesModel]?,suceess,data) in
            if suceess == true {
                if let Subcategor = Subcategor {
                    self.Subcategor = Subcategor
                    print("xxx\(self.Subcategor)")
                    self.tableView.reloadData()
                    
                }
            }else {
                self.showAlert(title: "No internet connection", message: data ?? "")
            }
            HPGradientLoading.shared.dismiss()
            
            if Subcategor?.count == 0 {
                self.tableView.isHidden = true
                self.noCatTF.isHidden = false
            }else {
                self.tableView.isHidden = false
                self.noCatTF.isHidden = true
            }
        }
    }
    
    
    
}


extension subCatVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? subCatCell {
            let cat = Subcategor[indexPath.row]
            cell.configuerCell(prodect: cat)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return categoryCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        self.performSegue(withIdentifier: "suge", sender: Subcategor[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Subcategor.count
        
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


extension subCatVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard searchTF.text?.isEmpty == true else {
            handleRefreshgetCat(url: URLs.searchSubCategory, search: searchTF.text ?? "")
            return false
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        handleRefreshgetCat(url: URLs.subcategories, search: searchTF.text ?? "")
        return true
    }
}
