//
//  ProgAddLanguageController.swift
//  CoreDataTest
//
//  Created by Michael Hayes on 4/30/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import UIKit

class ProgAddLanguageController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var addLanguageButton: UIButton!
    
    var _name:String = String()
    var date:String = String()
    var colorSelected:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addLanguageButton.alpha = 0
    }
    
    @IBAction func cancelAddLanguage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addLanguageButton(_ sender: Any) {
        
        _name = nameField.text!
        date = dateField.text!
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ProgrammingLangController
        destVC.langVC.name = _name
        destVC.langVC.date = date
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
