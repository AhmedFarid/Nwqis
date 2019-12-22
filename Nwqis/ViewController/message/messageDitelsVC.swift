//
//  messageDitelsVC.swift
//  Nwqis
//
//  Created by Farido on 12/22/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import HPGradientLoading

class messageDitelsVC: UIViewController {
    
    @IBOutlet weak var tabelView: UITableView!
    
    var myMessageDitals = [myMessageDiteals]()
    var singelItem: myMessageInbox?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.delegate = self
        tabelView.dataSource = self
        Spiner.addSpiner(isEnableDismiss: false, isBulurBackgroud: true, isBlurLoadin: true, durationAnimation: 1.5, fontSize: 20)
        handleRefreshgetGetmessages()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? replayMessageVC{
            if let sub = sender as? myMessageInbox{
                destaiantion.singleItem = sub
            }
        }
    }
    
    @objc private func handleRefreshgetGetmessages() {
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading(with: "Loading...")
        API_Messages.getMessageDiteals(shop_id: singelItem?.id ?? 0,owner: singelItem?.owner ?? ""){(error: Error?, myMessageDitals: [myMessageDiteals]?,suceess) in
            if let myMessageDitals = myMessageDitals {
                self.myMessageDitals = myMessageDitals
                print("xxx\(self.myMessageDitals)")
                self.tabelView.reloadData()
            }
            HPGradientLoading.shared.dismiss()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2588235294, green: 0.4039215686, blue: 0.6980392157, alpha: 1)
        handleRefreshgetGetmessages()
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
    
    
    @IBAction func replayBTN(_ sender: Any) {
        performSegue(withIdentifier: "suge", sender: singelItem)
    }
}


extension messageDitelsVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMessageDitals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? messageDitealsCell {
            let cat = myMessageDitals[indexPath.row]
            cell.configuerCell(prodect: cat)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return messageDitealsCell()
        }
    }
}
