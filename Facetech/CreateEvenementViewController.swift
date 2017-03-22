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
    
    @IBOutlet weak var nomEvenementTextField: UITextField!
    
    @IBOutlet weak var dateEvenementDatePicker: UIDatePicker!
    
    @IBOutlet weak var validerButton: UIButton!
    
    
    var nomEvenement : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nomEvenementTextField.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITextFieldDelegate Functions
    
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
        if (identifier == validerButton.accessibilityIdentifier)
        {
            self.textFieldDidEndEditing(nomEvenementTextField)
        
            var verif: Bool = true
        
            if (self.nomEvenement=="")
            {
                self.nomEvenementTextField.placeholder = "REMPLISSEZ CE CHAMP SVP"
                self.nomEvenementTextField.backgroundColor = UIColor.red
                verif = false
            }
        
            if (verif)
            {
                do
                {
                    var event = try EvenementsSetModel.evenementSet.insertEvenement(nom: self.nomEvenement, date: self.dateEvenementDatePicker.date);
                }
                catch let error as NSError
                {
                    DialogBoxHelper.alert(view : self, error: error)
                }
            }
        
            return verif
        }
        return true
    }
    
    
}
