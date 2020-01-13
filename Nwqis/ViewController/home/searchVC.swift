//
//  searchVC.swift
//  Nwqis
//
//  Created by Farido on 11/21/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import Kingfisher
import HPGradientLoading

class searchVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageview: UIPageControl!
    @IBOutlet weak var descrption: costomTV!
    @IBOutlet weak var requestImage: UIImageView!
    
    var timer = Timer()
    var currentIndex = 0
    var counter = 0
    
    
    var city_id = 0
    var state_id = 0
    var subcat = ""
    
    var catId = ""
    
    var singleItem: SubcategoriesModel?
    var singelItems: categoriesModel?
    var banner = [banners]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.layer.cornerRadius = 7.0
        collectionView.layer.borderWidth = 0.0
        collectionView.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        //handleRefreshgetBanner()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        if singelItems?.id == 0 {
            catId = singleItem?.category_id ?? ""
        }else if singleItem?.category_id == "0"{
            catId = "\(singelItems?.id ?? 0)"
        }
        
        self.navigationItem.title = "Search for your need"
        handleRefreshgetBanner()
        startTimer()
    }
    
    
    var picker_imag: UIImage? {
        didSet{
            guard let image = picker_imag else {return}
            requestImage.isHidden = false
            self.requestImage.image = image
        }
    }
    
    
    @IBAction func uplodImageBTN(_ sender: Any) {
        let piker = UIImagePickerController()
        piker.allowsEditing = true
        piker.sourceType = .photoLibrary
        piker.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Chose A Source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                piker.sourceType = .camera
                self.present(piker, animated: true, completion: nil)
            }else {
                print("notFound")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            piker.sourceType = .photoLibrary
            self.present(piker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    @IBAction func sendBTN(_ sender: Any) {
        
        guard let descrpti = descrption.text, !descrpti.isEmpty else {
            let messages = NSLocalizedString("enter description", comment: "hhhh")
            let title = NSLocalizedString("Request", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading(with: "Loading...")
        
        if singleItem?.id == nil{
            subcat = ""
        }else{
            subcat = "\(singleItem?.id ?? 0)"
        }
        
        
        
        API_Requests.addRequest(description: descrpti, city_id: "\(city_id)", state_id: "\(state_id)", lat: "0.0", lng: "0.0", category_id: "\(singelItems?.id ?? 0)\(singleItem?.category_id ?? "")", subcategory_id: subcat, image: requestImage.image ?? #imageLiteral(resourceName: "WhatsApp Image 2019-11-07 at 11.08.38 AM")) { (error, success, sucess, message, error1, erroer2) in
            if success{
                if sucess == true {
                    self.showAlert(title: "", message: "success add Request")
                    self.descrption.text = ""
                    self.requestImage.isHidden = true
                }
            }else{
                self.showAlert(title: "Internet Connection", message: "check internet connection")
            }
            HPGradientLoading.shared.dismiss()
        }
    }
    
    @objc private func handleRefreshgetBanner() {
        API_Requsests.getCatBanner(category_id: "\(singelItems?.id ?? 0)\(singleItem?.category_id ?? "")"){(error: Error?, banner: [banners]?,suceess) in
            if let banner = banner {
                self.banner = banner
                print("xxx\(self.banner)")
                self.collectionView.reloadData()
                self.pageview.numberOfPages =  banner.count
                self.pageview.currentPage = 0
            }
        }
    }
    
    func startTimer(){
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage() {
        
        if currentIndex < banner.count {
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageview.currentPage = currentIndex
            currentIndex += 1
        } else {
            currentIndex = 0
            let index = IndexPath.init(item: currentIndex, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageview.currentPage = currentIndex
            currentIndex = 1
        }
        
    }
    
    
    
    func navTitleWithImageAndText(titleText: String, imageName: String) -> UIView {
        
        // Creates a new UIView
        let titleView = UIView()
        
        // Creates a new text label
        let label = UILabel()
        label.text = titleText
        label.sizeToFit()
        label.center = titleView.center
        label.textAlignment = NSTextAlignment.center
        
        // Creates the image view
        let image = UIImageView()
        image.image = UIImage(named: imageName)
        
        // Maintains the image's aspect ratio:
        let imageAspect = image.image!.size.width / image.image!.size.height
        
        // Sets the image frame so that it's immediately before the text:
        let imageX = label.frame.origin.x - label.frame.size.height * imageAspect
        let imageY = label.frame.origin.y
        
        let imageWidth = label.frame.size.height * imageAspect
        let imageHeight = label.frame.size.height
        
        image.frame = CGRect(x: imageX, y: imageY, width: imageWidth, height: imageHeight)
        
        image.contentMode = UIView.ContentMode.scaleAspectFit
        
        // Adds both the label and image view to the titleView
        titleView.addSubview(label)
        titleView.addSubview(image)
        
        // Sets the titleView frame to fit within the UINavigation Title
        titleView.sizeToFit()
        
        return titleView
        
    }
    
}

extension searchVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banner.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell {
            let banners = banner[indexPath.row]
            cell.configuerCell(prodect: banners)
            return cell
        }else {
            return CollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
}

extension searchVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.picker_imag = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.picker_imag = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / collectionView	.frame.size.width)
        pageview.currentPage = currentIndex
    }
    
}
