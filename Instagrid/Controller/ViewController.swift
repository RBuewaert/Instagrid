//
//  ViewController.swift
//  Instagrid
//
//  Created by Romain Buewaert on 23/04/2021.
//

import UIKit

enum Layout {
    case one
    case two
    case three
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        currentLayout = .one
        
        // Swipe for Portrait orientation
        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeToShare(_:)))
        leftSwipeGestureRecognizer.direction = .left
        mainView.addGestureRecognizer(leftSwipeGestureRecognizer)
        
        // Swipe for Landscape orientation
        let upSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeToShare(_:)))
        upSwipeGestureRecognizer.direction = .up
        mainView.addGestureRecognizer(upSwipeGestureRecognizer)
    }
    
    var currentLayout: Layout = .one {
        didSet {
            updateMainView()
        }
    }
    var currentButton: UIButton?
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var photo2: UIButton!
    @IBOutlet weak var photo4: UIButton!
    
    @IBOutlet weak var layout1: UIButton!
    @IBOutlet weak var layout2: UIButton!
    @IBOutlet weak var layout3: UIButton!
    
    @IBAction func tapeLayout1(_ sender: Any) {
        currentLayout = .one
    }
    
    @IBAction func tapeLayout2(_ sender: Any) {
        currentLayout = .two
    }
    
    @IBAction func tapeLayout3(_ sender: Any) {
        currentLayout = .three
    }
    
    // Function valid for the 4 photo buttons
    @IBAction func addPhoto(_ sender: UIButton ) {
        sender.isSelected = true
        currentButton = sender
        chooseImage()
    }
    
    
    func updateMainView() {
        let layoutButtons = [layout1, layout2, layout3]
        for button in layoutButtons {
            button?.isSelected = false
        }
        switch currentLayout {
        case .one:
            layout1.isSelected = true
            photo2.isHidden = true
            photo4.isHidden = false
        case .two:
            layout2.isSelected = true
            photo2.isHidden = false
            photo4.isHidden = true
        case .three:
            layout3.isSelected = true
            photo2.isHidden = false
            photo4.isHidden = false
        }
    }
    
    // Show action sheet for choose a photo
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

//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }

    // Replace image for currentButton (continuity of function chooseImage)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        currentButton?.setImage((info[UIImagePickerController.InfoKey.originalImage] as! UIImage), for: .normal)
//        equivalent to: let choosedlmage = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
//        currentButton?.setimage(choosedImage, for .normal)
        currentButton?.imageView?.contentMode = . scaleAspectFill
        currentButton?.contentVerticalAlignment = .fill
        currentButton?.contentHorizontalAlignment = .fill
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Function to define the use of the UISwipeGestureRecognizer and the result
    @objc func swipeToShare(_ sender: UISwipeGestureRecognizer) {
        if UIApplication.shared.statusBarOrientation.isPortrait && sender.direction == .left {
            return
        }
        if UIApplication.shared.statusBarOrientation.isLandscape && sender.direction == .up {
            return
        }
        if sender.state == .ended {
            let screenHeight = UIScreen.main.bounds.height
            let screenWidth = UIScreen.main.bounds.width
            if UIApplication.shared.statusBarOrientation.isPortrait {
                let translation = CGAffineTransform(translationX: 0, y: -screenHeight)
                UIView.animate(withDuration: 0.5, animations: {
                    self.mainView.transform = translation
                }, completion: { (success) in
                    if success {
                        self.launchUIActivityController()
                    }
                })
            } else { // isLandscape
                let translation = CGAffineTransform(translationX: -screenWidth, y: 0)
                UIView.animate(withDuration: 0.5, animations: {
                    self.mainView.transform = translation
                }, completion: { (success) in
                    if success {
                        self.launchUIActivityController()
                    }
                })
            }
        }
    }
        
    // Function to launch the UIActivityController to share
    private func launchUIActivityController() {
        if let imageToShare = imageWithView(view: mainView) {
            let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
            
            activityViewController.completionWithItemsHandler = { (type, success, items, error) in
                UIView.animate(withDuration: 1, animations: {
                    self.mainView.transform = .identity
                }, completion: nil)
            }
        }
    }

    // Function to convert UIView to UIImage (utility to share an image for the user)
    private func imageWithView(view: UIView) -> UIImage? {
            UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return img
        }
}

