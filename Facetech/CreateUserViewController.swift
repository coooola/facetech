//
//  CreateUserViewController.swift
//  Facetech
//
//  Created by Nicolas BITAN on 02/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit
import CoreData

class CreateUserViewController: UIViewController, UITextFieldDelegate
{

    
    //MARK: - Objects
    
    @IBOutlet weak var prenomTextField: UITextField!
    
    @IBOutlet weak var nomTextField: UITextField!
    
    @IBOutlet weak var mailTextField: UITextField!
    
    var prenom : String = "";
    var nom : String = "";
    var mail : String = "";
    
    //MARK: - UIViewController function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prenomTextField.delegate = self
        nomTextField.delegate = self
        mailTextField.delegate = self;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - identifier: <#identifier description#>
    ///   - sender: <#sender description#>
    /// - Returns: <#return value description#>
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool
    {
       return self.saveNewPerson()
    }
    
    
    
    //MARK: - UITextField Functions
    
    /// <#Description#>
    ///
    /// - Parameter textField: <#textField description#>
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if  let saisiePrenom = self.prenomTextField.text
        {
            self.prenom = saisiePrenom;
        }
        if  let saisieNom = self.nomTextField.text
        {
            self.nom = saisieNom;
        }
        if let saisieMail = self.mailTextField.text
        {
            self.mail = saisieMail;
        }
    }

    
    
    
    //MARK: - Helper methods
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - errorMsg: <#errorMsg description#>
    ///   - userInfoMsg: <#userInfoMsg description#>
    /// - Returns: <#return value description#>
    func getContext(errorMsg: String, userInfoMsg: String = "could notr eretrieve data context") -> NSManagedObjectContext?
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            self.alert(WithTitle:errorMsg, andMessage: userInfoMsg)
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - msg: <#msg description#>
    func alert(WithTitle title: String, andMessage msg: String = "")
    {
        let alert = UIAlertController(title: title,
                                      message: msg,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated:true)
    }
    
    
    /// <#Description#>
    ///
    /// - Parameter error: <#error description#>
    func alert(error : NSError){
        self.alert(WithTitle: "\(error)", andMessage: "\(error.userInfo)")
    }
    
    
    
    
    //MARK: - Interaction with model functions
    
    func saveNewPerson() -> Bool
    {
        guard let context = self.getContext(errorMsg: "Could not load data") else {return false}
        
        let newUser = Utilisateur(context: context)
        newUser.adresseMail = self.mail
        newUser.nom = self.nom
        newUser.prenom = self.prenom
        newUser.motDePasse = self.prenom + "." + self.nom
        
        do
        {
            try context.save()
        }
        catch let error as NSError{
            self.alert(error: error)
            return false
        }
        
        return true
    }

    
    

}
