//
//  subCatVC.swift
//  Nwqis
//
//  Created by Farido on 12/12/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class subCatVC: UIViewController {

    @IBOutlet weak var loactionBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var Subcategor = [SubcategoriesModel]()
    var singleItem: categoriesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        handleRefreshgetCat()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let destaiantion = segue.destination as? searchVC{
               if let sub = sender as? SubcategoriesModel{
                   destaiantion.singleItem = sub
               }
           }
       }
    
    @objc private func handleRefreshgetCat() {
        API_CategoursAndSubCategours.getAllSubCategours(category_id: singleItem?.id ?? 0){(error: Error?, Subcategor: [SubcategoriesModel]?,suceess) in
            if let Subcategor = Subcategor {
                self.Subcategor = Subcategor
                print("xxx\(self.Subcategor)")
                self.tableView.reloadData()
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
