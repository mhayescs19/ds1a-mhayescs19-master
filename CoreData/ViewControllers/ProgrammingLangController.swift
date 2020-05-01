//
//  ProgrammingLangController.swift
//  CoreDataTest
//
//  Created by Michael Hayes on 4/23/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import UIKit
import CoreData

class ProgrammingLangController: UIViewController {
        
        private var managedObjectContext: NSManagedObjectContext!
        private var library = [ProgrammingLang()]
        
        var langVC = (name: "", date: "", colorSelected: "")
        
        @IBOutlet weak var tableView: UITableView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            // allows table to have access extension
            tableView.delegate = self
            tableView.dataSource = self
        }
        override func viewWillAppear(_ animated: Bool) {
            loadData()
        }
        func loadData(){
               do{
                library = try managedObjectContext.fetch(ProgrammingLang.fetchRequest())
               } catch {
                   print("Load failed due to \(error.localizedDescription)")
               }
            self.tableView.reloadData()
        }
        
        @IBAction func dismissScreen(_ sender: Any) {
            dismiss(animated: true, completion: nil) // goes back to last storyboard
        }
        @IBAction func addBookButton(_ sender: Any) {
            segueNewBookScreen()
        }
        
        func createNewLanguageData(){
          let newLanguage = ProgrammingLang(entity: ProgrammingLang.entity(), insertInto: managedObjectContext) // creates a new space for another set of "details" (username & password) using context
            newLanguage.name = langVC.name // sets name attribute from _name variable from other view controller
            newLanguage.dateCreated = langVC.date // sets language attribute from language variable from other
            newLanguage.colorSelected = langVC.colorSelected // sets color to string for UIColor(named: "colorSelected")
            do{
                 try self.managedObjectContext.save() // try = handler for errors; saves the new detail set inside of the entity
             } catch{
                 print("Save failed due to \(error.localizedDescription)") // if the save fails, displays error message
             }
            /*
             Debug check, displays entered details from Core Data
             */
            print("\(String(describing: newLanguage.name))")
            print("\(String(describing: newLanguage.dateCreated))")
            loadData() // loads new set of credentials from Core Data
        }
        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */
        func segueNewBookScreen(){
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil) // identifies current storyboard
             guard let ProgAddLangController = mainStoryboard.instantiateViewController(withIdentifier: "addLanguage") as? ProgAddLanguageController else { // sets next view controller to mainStoryboard (main)
                 print("Could not find viewController")
                 return
             }
             
            present(ProgAddLangController, animated: true, completion: nil) // puts login storyboard above main storyboard
        }
        /*
         Method format = unwindTo(ViewController name)
         Acts a destination point from any other VC in a stack. Method can also run another method on arrival (serves as completion from the other VC segue)
         */
        @IBAction func unwindToProgrammingLangController(_ unwindSegue: UIStoryboardSegue) {
            createNewLanguageData()
        }

    }

    extension ProgrammingLangController: UITableViewDataSource, UITableViewDelegate {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        // method purpose = determines number of cells needed from library [] count
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return library.count
        }
        // method purpose = "for loop" to set up each cell in table view
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let language = library[indexPath.row] // sets position to cycle through all of the books in the library (in Core Data "stack")
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell") as! ProgLanguageViewCell // finds cell type (only one in project
            
            /*
             Sets up each cell with data
             1. title
             2. author
             3. date published
             */
            cell.languageName.text = language.name
            cell.dateCreated.text = language.dateCreated
            cell.backgroundColor = UIColor(named: language.colorSelected!) ?? UIColor.white
            /*
             For better readability, if the color
             */
            switch cell.backgroundColor {
            case UIColor.white:
                cell.languageName.textColor = UIColor.black
                cell.dateCreated.textColor = UIColor.black
                break
            default:
                cell.languageName.textColor = UIColor.white
                cell.dateCreated.textColor = UIColor.white
            }
            
            return cell
        }
    }
