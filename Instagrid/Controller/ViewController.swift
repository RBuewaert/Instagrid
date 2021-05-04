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
        
        // Swipe for Portrait orientation
        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeToShare(_:)))
        leftSwipeGestureRecognizer.direction = .left
        mainView.addGestureRecognizer(leftSwipeGestureRecognizer)
        
        // Swipe for Landscape orientation
        let upSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeToShare(_:)))
        upSwipeGestureRecognizer.direction = .up
        mainView.addGestureRecognizer(upSwipeGestureRecognizer)
        
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
        sender.isSelected = true
        chooseImage()
    }
    
    @IBAction func addPhoto2(_ sender: UIButton) {
        sender.isSelected = true
        chooseImage()
    }
    
    @IBAction func addPhoto3(_ sender: UIButton) {
        sender.isSelected = true
        chooseImage()
    }
    
    @IBAction func addPhoto4(_ sender: UIButton) {
        sender.isSelected = true
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
    
    @objc func swipeToShare(_ sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            let screenHeight = UIScreen.main.bounds.height
            let screenWidth = UIScreen.main.bounds.width
            if UIDevice.current.orientation.isPortrait {
                let translation = CGAffineTransform(translationX: 0, y: -screenHeight)
                UIView.animate(withDuration: 0.5, animations: {
                    self.mainView.transform = translation
                }, completion: { (success) in
                    if success {
                        self.launchUIActivityController()
                    }
                })

            } else if UIDevice.current.orientation.isLandscape {
                let translation = CGAffineTransform(translationX: -screenWidth, y: 0)
                UIView.animate(withDuration: 0.5, animations: {
                    self.mainView.transform = translation
                }, completion: { (success) in
                    if success {
                        self.launchUIActivityController()
                    }
                })

            } else {
            }
        }
    }
    
    
    
    

        
    private func launchUIActivityController() {
        
        if let imageToShare = imageWithView(view: mainView) {
            let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
        UIView.animate(withDuration: 1, animations: {
            self.mainView.transform = .identity
        }, completion: nil)
        
    }
    
    private func imageWithView(view: UIView) -> UIImage? {
            UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return img
        }
        
        
        
//        switch orientation {
//        case .portrait:
//            gesture.direction = .up
//            mainView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
//
//
//        case .landscapeLeft, .landscapeRight:
//            gesture.direction = .left
//            mainView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
//
//
//        default:
//            break
//        }
        
//        private func transformQuestionViewWith(gesture: UIPanGestureRecognizer){
//            let translation = gesture.translation(in: questionView)
//            let translationTransform = CGAffineTransform(translationX: translation.x, y: translation.y)
//
//            let translationPercent = translation.x / (UIScreen.main.bounds.width / 2)
//            let rotationAngle = (CGFloat.pi / 3) * translationPercent
//            let rotationTransform = CGAffineTransform(rotationAngle: rotationAngle)
//
//            let transform = translationTransform.concatenating(rotationTransform)
//            questionView.transform = transform
//
//            if translation.x > 0 {
//                questionView.style = .correct
//            } else {
//                questionView.style = .incorrect
//            }
//        }
//
        

    
    
    
    
//    EXEMPLE MOINS INTERTESSANT
//    @objc func upSwipeToShare(_ sender: UISwipeGestureRecognizer) {
//        switch sender.state {
//        case .began, .changed :
//            upTransformMainViewWith(gesture: sender)
//        case .ended, .cancelled:
//            launchUIActivityController()
//        default:
//            break
//        }
//    }
//
//    private func upTransformMainViewWith(gesture: UISwipeGestureRecognizer) {
//        let translation = gesture.direction
//
//    }
    
    
    
    
    
//EXEMPLE VIDEO YOUTUBE
//@objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
//
//        if (sender.direction == .left) {
//            print("Swipe Left")
//            let labelPosition = CGPoint(x: self.swipeLabel.frame.origin.x - 50.0, y: self.swipeLabel.frame.origin.y)
//            swipeLabel.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: self.swipeLabel.frame.size.width, height: self.swipeLabel.frame.size.height)
//        }
//
//        if (sender.direction == .right) {
//            print("Swipe Right")
//            let labelPosition = CGPoint(x: self.swipeLabel.frame.origin.x + 50.0, y: self.swipeLabel.frame.origin.y)
//            swipeLabel.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: self.swipeLabel.frame.size.width, height: self.swipeLabel.frame.size.height)
//        }
//    }
    






//question avec 2 sol proposées

//// swipe left
//let left = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
//left.direction = .left
//self.swipeUp.addGestureRecognizer(left)
//
//
//@objc private func swipe() {
//    guard UIDevice.current.orientation == .landscapeLeft else {
//        return
//    }
//    // your code
//}




//class ViewController: UIViewController, UIGestureRecognizerDelegate {
//
//    func viewDidLoad() {
//        super.viewDidLoad()
//        let left = UISwipeGestureRecognizer(target: self, action:#selector(swipe))
//        left.direction = .left
//        self.swipeUp.addGestureRecognizer(left)
//    }
//
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        let gesture = gestureRecognizer as? UISwipeGestureRecognizer
//
//        switch uidevice.orientation {
//            case .portrait: return gesture.direction == .up
//            case .landscape: return gesture.direction == .left
//            default : return false
//        }
//    }
//}
    
    
    
    
    
    
   
}

