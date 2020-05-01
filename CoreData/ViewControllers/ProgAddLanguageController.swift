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
    var colorType = (green: "appGreen", yellow: "appYellow", orange: "appOrange") // tupe enum
    var currentColor:String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addLanguageButton.alpha = 0
    }
    
    @IBAction func cancelAddLanguage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // color selectors for cell color in table view
    @IBAction func greenButton(_ sender: Any) {
        colorSelected = true
        currentColor = colorType.green // uses tuple as an enum to get string name for color selector
        addLanguageButton.alpha = 1
    }
    
    @IBAction func yellowButton(_ sender: Any) {
        colorSelected = true
        currentColor = colorType.yellow // uses tuple as an enum to get string name for color selector
        addLanguageButton.alpha = 1
    }
    
    @IBAction func orangeButton(_ sender: Any) {
        colorSelected = true
        currentColor = colorType.orange // uses tuple as an enum to get string name for color selector
        addLanguageButton.alpha = 1
    }
    
    @IBAction func addLanguageButton(_ sender: Any) {
        
        _name = nameField.text!
        date = dateField.text!
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ProgrammingLangController
        destVC.langVC.name = _name
        destVC.langVC.date = date
        destVC.langVC.colorSelected = currentColor
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
