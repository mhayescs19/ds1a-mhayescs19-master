//
//  ViewController.swift
//  CoreData
//
//  Created by Michael Hayes on 4/22/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    

    
     override func viewDidLoad() {
         super.viewDidLoad()

     }
    @IBAction func LoginScreen(_ sender: Any) {
        let loginStoryboard = UIStoryboard(name: "Main", bundle: nil) // identifies current storyboard
            guard let LoginScreenController = loginStoryboard.instantiateViewController(withIdentifier: "loginScreen") as? LoginScreenController else { // sets next view controller to mainStoryboard (main)
                print("Could not find viewController")
                return
            }
            
           present(LoginScreenController, animated: true, completion: nil) // puts login storyboard above main storyboard
        }
    @IBAction func ProgrammingLanguagesScreen(_ sender: Any) {
    let programmingLangStoryboard = UIStoryboard(name: "Main", bundle: nil) // identifies current storyboard
        guard let ProgrammingLanguagesController = programmingLangStoryboard.instantiateViewController(withIdentifier: "programmingLanguages") as? ProgrammingLangController else { // sets next view controller to mainStoryboard (main)
            print("Could not find viewController")
            return
        }
        
       present(ProgrammingLanguagesController, animated: true, completion: nil) // puts login storyboard above main storyboard
    }
    @IBAction func LibraryScreen(_ sender: Any) {
    let libraryStoryboard = UIStoryboard(name: "Main", bundle: nil) // identifies current storyboard
        guard let libraryController = libraryStoryboard.instantiateViewController(withIdentifier: "library") as? LibraryController else { // sets next view controller to mainStoryboard (main)
            print("Could not find viewController")
            return
        }
        
       present(libraryController, animated: true, completion: nil) // puts login storyboard above main storyboard
    }
}


