//
//  messageHomeVC.swift
//  Nwqis
//
//  Created by Farido on 12/22/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import HPGradientLoading

class messageHomeVC: UIViewController {
    
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var Label: UILabel!
    
    var myMessage = [myMessageInbox]() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegment()
        handleRefreshgetGetmessages(Type: "shop")
        Spiner.addSpiner(isEnableDismiss: false, isBulurBackgroud: true, isBlurLoadin: true, durationAnimation: 1.5, fontSize: 20)
        tabelView.delegate = self
        tabelView.dataSource = self
        
    }
    
    @objc private func handleRefreshgetGetmessages(Type: String) {
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading(with: "Loading...")
        API_Messages.getMessageHistory(owner: Type){(error: Error?, myMessage: [myMessageInbox]?,suceess) in
            if let myMessage = myMessage {
                self.myMessage = myMessage
                print("xxx\(self.myMessage)")
                self.tabelView.reloadData()
            }
            if myMessage?.count == 0 {
                self.tabelView.isHidden = true
                self.Label.isHidden = false
            }else {
                self.tabelView.isHidden = false
                self.Label.isHidden = true
            }
            HPGradientLoading.shared.dismiss()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? messageDitelsVC{
            if let sub = sender as? myMessageInbox{
                destaiantion.singelItem = sub
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
    
    func setupSegment(){
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        //segmentView.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentView.setTitleTextAttributes(titleTextAttributes, for: .selected)
        segmentView.layer.cornerRadius = segmentView.bounds.height / 2
        segmentView.layer.borderWidth = 3
        segmentView.layer.borderColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        segmentView.clipsToBounds = true
        segmentView.layer.masksToBounds = true
        
        if #available(iOS 13.0, *) {
            segmentView.selectedSegmentTintColor = #colorLiteral(red: 0.09394007176, green: 0.2400603294, blue: 0.4907802343, alpha: 1)
            segmentView.layer.cornerRadius = segmentView.bounds.height / 2
        }
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        switch segmentView.selectedSegmentIndex {
        case 0:
            handleRefreshgetGetmessages(Type: "shop")
        case 1:
            handleRefreshgetGetmessages(Type: "customer")
        default:
            break;
        }
    }
    
}


extension messageHomeVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? historyMessageCell {
            let cat = myMessage[indexPath.row]
            cell.configuerCell(prodect: cat)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return historyMessageCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "suge", sender: myMessage[indexPath.row])
    }
}
