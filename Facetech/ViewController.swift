//
//  ViewController.swift
//  Facetech
//
//  Created by Nicolas BITAN on 13/02/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {

    
    //MARK: Properties
    

    @IBOutlet weak var identifiantTextField: UITextField!
    
    @IBOutlet weak var mdpTextField: UITextField!
    
    @IBOutlet weak var messageErreurLabel: UILabel!
    
    var id : String = "";
    var mdp : String = "";
    
    
    
    
    //MARK: - UIViewController methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        identifiantTextField.delegate = self
        mdpTextField.delegate = self
        messageErreurLabel.isHidden = true;
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    //MARK: - UITextFieldDelegate
    
    /// <#Description#>
    ///
    /// - Parameter textField: <#textField description#>
    /// - Returns: <#return value description#>
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        identifiantTextField.resignFirstResponder();
        mdpTextField.resignFirstResponder();
        return true;
    }
    
    /// <#Description#>
    ///
    /// - Parameter textField: <#textField description#>
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if  let saisieId = self.identifiantTextField.text
        {
            self.id = saisieId;
        }
        if  let saisieMdp = self.mdpTextField.text
        {
            self.mdp = saisieMdp;
        }
    }

    
    
    //MARK: - Navigation
    
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - identifier: <#identifier description#>
    ///   - sender: <#sender description#>
    /// - Returns: <#return value description#>
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool
    {
        guard let context = self.getContext(errorMsg: "Could not load data") else {return false}
        
        var user : [Utilisateur] = []
        
        let request : NSFetchRequest<Utilisateur> = Utilisateur.fetchRequest()
        do{
            try user = context.fetch(request)
        }
        catch let error as NSError{
            self.alert(error: error)
        }
        for people in user
        {
            if people.adresseMail == self.id && people.motDePasse == self.mdp
            {
                messageErreurLabel.isHidden = true;
                return true
            }
        }
        messageErreurLabel.isHidden = false;
        return false
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
    
    

}

