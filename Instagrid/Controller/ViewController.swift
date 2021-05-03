//
//  ViewController.swift
//  Instagrid
//
//  Created by Romain Buewaert on 23/04/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectLayout(withPortraitButton: layout1P, withLandscapeButton: layout1L, topViewIshidden: true, bottomViewIsHidden: false)
    }
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var photo1: UIButton!
    @IBOutlet weak var photo2: UIButton!
    @IBOutlet weak var photo3: UIButton!
    @IBOutlet weak var photo4: UIButton!
    
    @IBOutlet weak var layout1P: UIButton!
    @IBOutlet weak var layout2P: UIButton!
    @IBOutlet weak var layout3P: UIButton!
    
    @IBOutlet weak var layout1L: UIButton!
    @IBOutlet weak var layout2L: UIButton!
    @IBOutlet weak var layout3L: UIButton!
    
    @IBAction func tapeLayout1P(_ sender: Any) {
        selectLayout(withPortraitButton: layout1P, withLandscapeButton: layout1L, topViewIshidden: true, bottomViewIsHidden: false)
    }
    
    @IBAction func tapeLayout2P(_ sender: Any) {
        selectLayout(withPortraitButton: layout2P, withLandscapeButton: layout2L, topViewIshidden: false, bottomViewIsHidden: true)
    }
    
    @IBAction func tapeLayout3P(_ sender: Any) {
        selectLayout(withPortraitButton: layout3P, withLandscapeButton: layout3L, topViewIshidden: false, bottomViewIsHidden: false)
    }
    
    @IBAction func tapeLayout1L(_ sender: Any) {
        selectLayout(withPortraitButton: layout1P, withLandscapeButton: layout1L, topViewIshidden: true, bottomViewIsHidden: false)
    }
    
    @IBAction func tapeLayout2L(_ sender: Any) {
        selectLayout(withPortraitButton: layout2P, withLandscapeButton: layout2L, topViewIshidden: false, bottomViewIsHidden: true)
    }
    
    @IBAction func tapeLayout3L(_ sender: Any) {
        selectLayout(withPortraitButton: layout3P, withLandscapeButton: layout3L, topViewIshidden: false, bottomViewIsHidden: false)
    }
    
    @IBAction func addPhoto1(_ sender: UIButton) {
        photo1.isSelected = true
        chooseImage()
    }
    
    @IBAction func addPhoto2(_ sender: UIButton) {
        photo2.isSelected = true
        chooseImage()
    }
    
    @IBAction func addPhoto3(_ sender: UIButton) {
        photo3.isSelected = true
        chooseImage()
    }
    
    @IBAction func addPhoto4(_ sender: UIButton) {
        photo4.isSelected = true
        chooseImage()
    }
    
    var choosedlmage: UIImage!
    
    func selectLayout(withPortraitButton: UIButton, withLandscapeButton: UIButton, topViewIshidden: Bool, bottomViewIsHidden: Bool) {
        let buttons = [layout1P, layout1L, layout2P, layout2L, layout3P, layout3L]
        for button in buttons {
            button!.isSelected = false
        }
        withPortraitButton.isSelected = true
        withLandscapeButton.isSelected = true
        if topViewIshidden == true {
            photo2.isHidden = true
        } else {
            photo2.isHidden = false
        }
        if bottomViewIsHidden == true {
            photo4.isHidden = true
        } else {
            photo4.isHidden = false
        }
    }
    
    private func changeImage() {
        if photo1.isSelected == true {
            photo1.setImage(choosedlmage, for: .normal)
            photo1.isSelected = false
        } else if photo2.isSelected == true {
            photo2.setImage(choosedlmage, for: .normal)
            photo2.isSelected = false
        } else if photo3.isSelected == true {
            photo3.setImage(choosedlmage, for: .normal)
            photo3.isSelected = false
        } else { // photo4.isSelected == true
            photo4.setImage(choosedlmage, for: .normal)
            photo4.isSelected = false
        }
    }
    
    func chooseImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self

        let actionSheet = UIAlertController(title: "Picture Source", message: "Choose a source", preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(alert: UIAlertAction!) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                imagePickerController.cameraCaptureMode = .photo
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("Camera not available")
            }
        }))

        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(alert: UIAlertAction!) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("Photo library not available")
            }
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(actionSheet, animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        choosedlmage = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        changeImage()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func swipeToShare() {
        
        
        
    }
    
    
   
}

