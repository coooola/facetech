//
//  CreateEvenementViewController.swift
//  Facetech
//
//  Created by Polytech on 21/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit
import CoreData

class CreateEvenementViewController: UIViewController, UITextFieldDelegate
{
    
    //MARK: - OUTLETS -
    
    @IBOutlet weak var nomEvenementTextField: UITextField!
    @IBOutlet weak var dateEvenementDatePicker: UIDatePicker!
    @IBOutlet weak var validerButton: UIButton!
    
    
    //MARK: - VARIABLE -
    
    var nomEvenement : String = ""
    
    
    //MARK: - UIViewController function -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nomEvenementTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITextFieldDelegate Functions -
    
    /// <#Description#>
    ///
    /// - Parameter textField: <#textField description#>
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if  let nomEv = self.nomEvenementTextField.text
        {
            self.nomEvenement = nomEv;
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.nomEvenementTextField.backgroundColor = UIColor.white
        
    }
    
    /// <#Description#>
    ///
    /// - Parameter textField: <#textField description#>
    /// - Returns: <#return value description#>
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder();
        return true;
    }
    
    //MARK: - Actions -
    
    /// Go to the previous page
    ///
    @IBAction func cancelAction(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation -
    
    
    /// Check if the textField are not empty
    ///
    /// - Parameters:
    ///   - identifier: the identifier
    ///   - sender: the sender
    /// - Returns: a boolean true if it's not empty
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool
    {
        self.textFieldDidEndEditing(nomEvenementTextField)
        if (self.nomEvenement=="")
        {
                self.nomEvenementTextField.placeholder = "REMPLISSEZ CE CHAMP SVP"
                self.nomEvenementTextField.backgroundColor = UIColor.red
                return false
        }
        return true
    }
    
    
}
