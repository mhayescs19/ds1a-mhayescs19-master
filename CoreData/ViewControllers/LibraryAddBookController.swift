//
//  LibraryAddBookController.swift
//  CoreDataTest
//
//  Created by Michael Hayes on 4/24/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import UIKit

class LibraryAddBookController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    
    // local book data from text fields (to be passed to LibraryController VC)
    var _title:String = String()
    var author:String = String()
    var date:String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func cancelAddBook(_ sender: Any) {
        dismiss(animated: true, completion: nil) // goes back to last storyboard
    
    }
    
    @IBAction func addBookToTable(_ sender: Any) {
        
        _title = titleField.text!
        author = authorField.text!
        date = dateField.text!
        /*guard _title == titleField.text!, !_title.isEmpty else { return } // if there is not value in the text field, it does not pass nil to Core Data
        guard author == authorField.text!, !author.isEmpty else { return } // if there is not value in the text field, it does not pass nil to Core Data
        guard date == dateField.text!, !date.isEmpty else { return } // if there is not value in the text field, it does not pass nil to Core Data*/
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! LibraryController
        destVC.bookVC.title = _title
        destVC.bookVC.author = author
        destVC.bookVC.date = date
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
