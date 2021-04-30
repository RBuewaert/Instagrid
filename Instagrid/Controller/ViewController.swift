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
        selectLayout1()
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
        selectLayout1()
    }
    
    @IBAction func tapeLayout2P(_ sender: Any) {
        selectLayout2()
    }
    
    @IBAction func tapeLayout3P(_ sender: Any) {
        selectLayout3()
    }
    
    @IBAction func tapeLayout1L(_ sender: Any) {
        selectLayout1()
    }
    
    @IBAction func tapeLayout2L(_ sender: Any) {
        selectLayout2()
    }
    
    @IBAction func tapeLayout3L(_ sender: Any) {
        selectLayout3()
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
    
    func changeImage() {
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
    
    func selectLayout1() {
        layout1P.isSelected = true
        layout1L.isSelected = true
        layout2P.isSelected = false
        layout2L.isSelected = false
        layout3P.isSelected = false
        layout3L.isSelected = false
        photo2.isHidden = true
        photo4.isHidden = false
    }
    
    func selectLayout2() {
        layout1P.isSelected = false
        layout1L.isSelected = false
        layout2P.isSelected = true
        layout2L.isSelected = true
        layout3P.isSelected = false
        layout3L.isSelected = false
        photo2.isHidden = false
        photo4.isHidden = true
    }
    
    func selectLayout3() {
        layout1P.isSelected = false
        layout1L.isSelected = false
        layout2P.isSelected = false
        layout2L.isSelected = false
        layout3P.isSelected = true
        layout3L.isSelected = true
        photo2.isHidden = false
        photo4.isHidden = false
    }
}

