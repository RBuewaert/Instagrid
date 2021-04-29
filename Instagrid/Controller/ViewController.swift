//
//  ViewController.swift
//  Instagrid
//
//  Created by Romain Buewaert on 23/04/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectLayout1()
    }
    
//    enum Layout {
//        case layout1, layout2, layout3
//    }
//
//    func layoutConfiguration() {
//        if layout1P.isTouchInside == true {
//
//        }
//    }
    
    

    
    
    func selectLayout1() {
        layout1P.isSelected = true
        layout1L.isSelected = true
        layout2P.isSelected = false
        layout2L.isSelected = false
        layout3P.isSelected = false
        layout3L.isSelected = false
        topPicture.isHidden = true
        bottomPicture.isHidden = false
    }
    
    func selectLayout2() {
        layout1P.isSelected = false
        layout1L.isSelected = false
        layout2P.isSelected = true
        layout2L.isSelected = true
        layout3P.isSelected = false
        layout3L.isSelected = false
        topPicture.isHidden = false
        bottomPicture.isHidden = true
    }
    
    func selectLayout3() {
        layout1P.isSelected = false
        layout1L.isSelected = false
        layout2P.isSelected = false
        layout2L.isSelected = false
        layout3P.isSelected = true
        layout3L.isSelected = true
        topPicture.isHidden = false
        bottomPicture.isHidden = false
    }
    
    
    
    
    
    @IBOutlet weak var topPicture: UIButton!
    @IBOutlet weak var bottomPicture: UIButton!
    
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
    
    
    @IBAction func addPhoto1(_ sender: Any) {
        
    }
    
    
    @IBAction func addPhoto2(_ sender: Any) {
        
    }
    
    
    @IBAction func addPhoto3(_ sender: Any) {
        
    }
    
    
    @IBAction func addPhoto4(_ sender: Any) {
        
    }
    

}

