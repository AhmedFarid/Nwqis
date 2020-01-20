//
//  replayMessageVC.swift
//  Nwqis
//
//  Created by Farido on 12/22/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import HPGradientLoading

class replayMessageVC: UIViewController {

    @IBOutlet weak var addresss: UILabel!
    @IBOutlet weak var messageToLabel: UILabel!
    @IBOutlet weak var phoneLB: UILabel!
    @IBOutlet weak var messageTF: costomTV!
    @IBOutlet weak var images: UIImageView!
    
    var singleItems: myRequestsDitels?
    var singleItem: myMessageInbox?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Spiner.addSpiner(isEnableDismiss: false, isBulurBackgroud: true, isBlurLoadin: true, durationAnimation: 1.5, fontSize: 20)
        let message = NSLocalizedString("message to:", comment: "profuct list lang")
        messageToLabel.text = "\(message) \(singleItem?.name ?? singleItems?.name ?? "")"
         phoneLB.text = "\(singleItem?.phone ?? singleItems?.phone ?? "")"
        addresss.text = "\(singleItem?.address ?? singleItems?.address ?? "")"
        
    }
    
    
    var picker_imag: UIImage? {
        didSet{
            guard let image = picker_imag else {return}
            images.isHidden = false
            self.images.image = image
        }
    }
    
    
    @IBAction func sendBTN(_ sender: Any) {
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .blue
        HPGradientLoading.shared.showLoading(with: "Loading...")
        
        
        API_Messages.newMessage(image: images.image ?? #imageLiteral(resourceName: "WhatsApp Image 2019-11-07 at 11.08.38 AM"), message: messageTF.text ?? "", shop_id: "\(singleItem?.id ?? singleItems?.id ?? 0)"){ (error, success, sucess, message, error1, erroer2) in
            if success{
                if sucess == true {
                    let message = NSLocalizedString("success add Request", comment: "profuct list lang")
                    self.showAlert(title: "", message: message)
                }
            }else{
                let message = NSLocalizedString("check internet connection", comment: "profuct list lang")
                self.showAlert(title: "", message: message)
            }
            HPGradientLoading.shared.dismiss()
        }
        
    }
    
    @IBAction func addImage(_ sender: Any) {
        
        let piker = UIImagePickerController()
        piker.allowsEditing = true
        piker.sourceType = .photoLibrary
        piker.delegate = self
        let title = NSLocalizedString("Photo Source", comment: "profuct list lang")
        let message = NSLocalizedString("Chose A Source", comment: "profuct list lang")
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let titles = NSLocalizedString("Camera", comment: "profuct list lang")
        actionSheet.addAction(UIAlertAction(title: titles, style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                piker.sourceType = .camera
                self.present(piker, animated: true, completion: nil)
            }else {
                print("notFound")
            }
        }))
        let titless = NSLocalizedString("Photo Library", comment: "profuct list lang")
        actionSheet.addAction(UIAlertAction(title: titless, style: .default, handler: { (action:UIAlertAction) in
            piker.sourceType = .photoLibrary
            self.present(piker, animated: true, completion: nil)
        }))
        let titlesss = NSLocalizedString("Cancel", comment: "profuct list lang")
        actionSheet.addAction(UIAlertAction(title: titlesss, style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
}


extension replayMessageVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
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
}
