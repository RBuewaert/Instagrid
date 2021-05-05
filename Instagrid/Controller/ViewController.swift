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
            updateView()
        }
    }
    
    @IBOutlet weak var swipeToShareLabel: UILabel! {
        didSet {
            if UIApplication.shared.statusBarOrientation.isPortrait {
                self.swipeToShareLabel.text = "Swipe up to share"
            } else {
                self.swipeToShareLabel.text = "Swipe left to share"
            }
        }
    }
    
    func editLabel(Label : UILabel) {
        if UIApplication.shared.statusBarOrientation.isPortrait {
            Label.text = "swipe up to share"
        } else {
            Label.text = "swipe left to share"
        }
    }
    
    
    @IBOutlet weak var arrowToShare: UIImageView!
    
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var photo1: UIButton!
    @IBOutlet weak var photo2: UIButton!
    @IBOutlet weak var photo3: UIButton!
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
    
    var currentButton: UIButton?
    @IBAction func addPhoto(_ sender: UIButton ) {
        sender.isSelected = true
        currentButton = sender
        chooseImage()
    }
    
//    @IBAction func addPhoto1(_ sender: UIButton) {
//        sender.isSelected = true
//        chooseImage()
//    }
//
//    @IBAction func addPhoto2(_ sender: UIButton) {
//        sender.isSelected = true
//        chooseImage()
//    }
//
//    @IBAction func addPhoto3(_ sender: UIButton) {
//        sender.isSelected = true
//        chooseImage()
//    }
//
//    @IBAction func addPhoto4(_ sender: UIButton) {
//        sender.isSelected = true
//        chooseImage()
//    }
    
    var choosedlmage: UIImage!
    
    
    
    var orientation: UIDeviceOrientation!
    
   
    
    
    func updateView() {
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
    
//    func selectLayout(withPortraitButton: UIButton, withLandscapeButton: UIButton, topViewIshidden: Bool, bottomViewIsHidden: Bool) {
//        let buttons = [layout1P, layout1L, layout2P, layout2L, layout3P, layout3L]
//        for button in buttons {
//            button!.isSelected = false
//        }
//        withPortraitButton.isSelected = true
//        withLandscapeButton.isSelected = true
//        if topViewIshidden == true {
//            photo2.isHidden = true
//        } else {
//            photo2.isHidden = false
//        }
//        if bottomViewIsHidden == true {
//            photo4.isHidden = true
//        } else {
//            photo4.isHidden = false
//        }
//    }
    
    private func changeImage() {
        currentButton?.setImage(choosedlmage, for: .normal)
//        if photo1.isSelected == true {
//            photo1.setImage(choosedlmage, for: .normal)
//            photo1.isSelected = false
//        } else if photo2.isSelected == true {
//            photo2.setImage(choosedlmage, for: .normal)
//            photo2.isSelected = false
//        } else if photo3.isSelected == true {
//            photo3.setImage(choosedlmage, for: .normal)
//            photo3.isSelected = false
//        } else { // photo4.isSelected == true
//            photo4.setImage(choosedlmage, for: .normal)
//            photo4.isSelected = false
//        }
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
        currentButton?.setImage((info[UIImagePickerController.InfoKey.originalImage] as! UIImage), for: .normal)
//        choosedlmage = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
//        changeImage()
        picker.dismiss(animated: true, completion: nil)
    }
    
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

            } else {
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
//            activityViewController.CompletionHandler {
//                returnToMainScreen() }
//
//            activityViewController.completionWithItemsHandler = { (success) in
//                if success {
//                    self.returnToMainScreen()
//                }
//            }
            
        }
//        UIActivityViewController.CompletionHandler.self: returnToMainScreen()
        
//        UIView.animate(withDuration: 1, animations: {
//            self.mainView.transform = .identity
//        }, completion: nil)
       
    }
    
    private func returnToMainScreen() {
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
        

    
    
    
    
//    @objc func upSwipeToShare(_ sender: UISwipeGestureRecognizer) {
//        switch sender.state {
//        case .began :
//            upTransformMainViewWith(gesture: sender)
//        case .ended :
//            launchUIActivityController()
//        default:
//            break
//        }
//    }

   
}

