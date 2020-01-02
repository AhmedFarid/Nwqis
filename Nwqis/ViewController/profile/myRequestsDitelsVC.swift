//
//  myRequestsDitelsVC.swift
//  Nwqis
//
//  Created by Farido on 12/18/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import HPGradientLoading

class myRequestsDitelsVC: UIViewController {
    
    @IBOutlet weak var catInfoLabel: UILabel!
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var hightContrines: NSLayoutConstraint!
    
    var myRequestsDitel = [myRequestsDitels]()
    var singleItem: myRequests?
    var TabelHight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
        tabelView.delegate = self
        tabelView.dataSource = self
        Spiner.addSpiner(isEnableDismiss: false, isBulurBackgroud: true, isBlurLoadin: true, durationAnimation: 1.5, fontSize: 20)
        handleRefreshgetRequestsDitels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? replayMessageVC{
            if let sub = sender as? myRequestsDitels{
                destaiantion.singleItems = sub
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
           navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2588235294, green: 0.4039215686, blue: 0.6980392157, alpha: 1)
           setUpNavColore(false)
           
       }
       
       
       override func viewWillDisappear(_ animated: Bool) {
           //        navigationController?.navigationBar.barTintColor = UIColor.white
           setUpNavColore(true)
           
       }
    
    func setUpNavColore(_ isTranslucent: Bool){
           self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
           self.navigationController?.navigationBar.shadowImage = UIImage()
           self.navigationController?.navigationBar.isTranslucent = isTranslucent
       }
    
    func setUpView() {
        image.layer.cornerRadius = 5
        image.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        image.layer.borderWidth = 1
        descText.text = singleItem?.descriptin
        catInfoLabel.text = "Request to: \(singleItem?.category_name ?? "") \(singleItem?.subcategory_name ?? "")"
        let x = singleItem?.image ?? ""
        let encodedLinkx = x.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURLx = NSURL(string: encodedLinkx!)! as URL
        image.kf.indicatorType = .activity
        if let urlx = URL(string: "\(encodedURLx)") {
            image.kf.setImage(with: urlx)
        }
    }
    
    @objc private func handleRefreshgetRequestsDitels() {
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading(with: "Loading...")
        API_Requests.getMyRequestsDitels(shortlist_id: "\(singleItem?.id ?? 0)"){(error: Error?, myRequestsDitel: [myRequestsDitels]?,suceess) in
            if let myRequestsDitel = myRequestsDitel {
                self.myRequestsDitel = myRequestsDitel
                print("xxx\(self.myRequestsDitel)")
                self.tabelView.reloadData()
                
            }
            
            self.hightContrines.constant = self.descText.frame.height + (self.TabelHight ?? 0.0) * CGFloat(self.myRequestsDitel.count)
            self.view.layoutIfNeeded()
            HPGradientLoading.shared.dismiss()
        }
    }
}


extension myRequestsDitelsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? myRequDItelsCell {
            let cat = myRequestsDitel[indexPath.row]
            cell.configuerCell(prodect: cat)
            TabelHight = cell.bounds.height
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.call = {
                guard let number = URL(string: "tel://" + self.myRequestsDitel[indexPath.row].phone) else { return }
                UIApplication.shared.open(number)
            }
            
            cell.message = {
                print("xxxxxx")
            }
            
            cell.message = {
                self.performSegue(withIdentifier: "messageSuge", sender: self.myRequestsDitel[indexPath.row])
            }
            return cell
        }else {
            return myRequDItelsCell()
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRequestsDitel.count
        
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
