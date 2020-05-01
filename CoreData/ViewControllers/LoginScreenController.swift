//
//  LoginScreenController.swift
//  CoreDataTest
//
//  Created by Michael Hayes on 4/23/20.
//  Copyright © 2020 Michael Hayes. All rights reserved.
//

import UIKit
import CoreData

class LoginScreenController: UIViewController {
    
    private var managedObjectContext: NSManagedObjectContext!
    private var userInfo = [Details()]
    var loginSuccess: Bool!
    var click = 0
    
    @IBOutlet weak var usernameCreate: UITextField!
    @IBOutlet weak var passwordCreate: UITextField!
     
    @IBOutlet weak var loginFailedPrompt: UILabel!
    @IBOutlet weak var textAdjustEye: UIButton!
    
     override func viewDidLoad() {
         super.viewDidLoad()

        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        loginFailedPrompt.alpha = 0 // hides failed login prompt
        passwordCreate.isSecureTextEntry = true
     }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    @IBAction func dismissScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil) // goes back to last storyboard
    }
    func loadData(){
            do{
                userInfo = try managedObjectContext.fetch(Details.fetchRequest())
            } catch {
                print("Load failed due to \(error.localizedDescription)")
            }
     }
     
    @IBAction func loginButton(_ sender: Any) {
        guard let username = usernameCreate.text, !username.isEmpty else { return } // if there is not value in the text field, it does not pass nil to Core Data
        guard let password = passwordCreate.text, !password.isEmpty else { return }

        checkCredentials(username: username, password: password)
    }
    func checkCredentials(username: String, password: String){
        /* Cycles through all of the usernames and passwords in the local variable from the fetched data and uses the count to only compare usernames and passwords added at the same time.
         */
        for i in 0..<userInfo.count {
             if(userInfo[i].username == username && userInfo[i].password == password) {
                 print("Login successful, @%d", i)
                loginSuccess = true
                loginHandler()
                return
             }else{
                loginSuccess = false
                loginHandler()
            }
         }
     }
    
    func loginSuccessScreen(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil) // identifies current storyboard
        guard let loginController = mainStoryboard.instantiateViewController(withIdentifier: "loginSuccess") as? LoginController else { // sets next view controller to mainStoryboard (main)
            print("Could not find viewController")
            return
        }
        
       present(loginController, animated: true, completion: nil) // puts login storyboard above main storyboard
    }
     @IBAction func createAccountCredentials(_ sender: Any) {
        guard let username = usernameCreate.text, !username.isEmpty else { return } // if there is not value in the text field, it does not pass nil to Core Data
        guard let password = passwordCreate.text, !password.isEmpty else { return }

         signUpSave(username: username, password: password)
     }
     
     func signUpSave(username: String, password: String){
        let newAccount = Details(entity: Details.entity(), insertInto: managedObjectContext) // creates a new space for another set of "details" (username & password) using context
         newAccount.username = username // sets username attribute to username entered from text field
         newAccount.password = password // sets password attribute to username entered from text field
         do{
             try self.managedObjectContext.save() // try = handler for errors; saves the new detail set inside of the entity
         } catch{
             print("Save failed due to \(error.localizedDescription)") // if the save fails, displays error message
         }
        /*
         Debug check, displays entered details from Core Data
         */
        print("\(String(describing: newAccount.username))")
        print("\(String(describing: newAccount.password))")
        
        loadData() // loads new set of credentials from Core Data
     }
    func loginHandler(){
        switch loginSuccess {
        case true:
            loginSuccessScreen()
            self.view.backgroundColor = .darkGray // changes background color back to original state
            loginFailedPrompt.alpha = 0
            break
        case false:
            self.view.backgroundColor = UIColor(named: "appRed")
            loginFailedPrompt.alpha = 1
            break
        default:
            break
        }
    }
    @IBAction func adjustTextView(_ sender: Any) {
        /*
         Simple logic using if statement to switch between a filled eye (look at the characters of the password) and slashed eye (hide the characters of the password
         */
        
        if click == 0 {
            click+=1
            textAdjustEye.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            passwordCreate.isSecureTextEntry = false
            return
        }else
        {
            click-=1
            textAdjustEye.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            passwordCreate.isSecureTextEntry = true
        }
    }
}
