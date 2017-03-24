//
//  MainPageViewController.swift
//  Facetech
//
//  Created by Nicolas BITAN on 14/02/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit
import CoreData

class MainPageViewController: UIViewController, UITextFieldDelegate {

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
        textField.resignFirstResponder();
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
        self.textFieldDidEndEditing(mdpTextField)
       
        var user : Utilisateur?
        do
        {
            try user = UtilisateursSetModel.utilisateursSet.getUtilisateurByMail(mail: self.id)
        }
        catch let error as NSError
        {
            DialogBoxHelper.alert(view : self, error: error)
        }
        
        if user != nil && user!.adresseMail == self.id && user!.motDePasse == self.mdp
        {
            messageErreurLabel.isHidden = true;
            Session.utilisateurConnecte = user;
            self.identifiantTextField.text = "";
            self.mdpTextField.text = "";
            return true
        }
        messageErreurLabel.isHidden = false;

        return false
    }
    
}
