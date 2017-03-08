//
//  CreateUserViewController.swift
//  Facetech
//
//  Created by Nicolas BITAN on 02/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit
import CoreData

class CreateUserViewController: UIViewController, UITextFieldDelegate//, UIPickerViewDataSource
{

    
    //MARK: - Objects
    
    @IBOutlet weak var prenomTextField: UITextField!
    
    @IBOutlet weak var nomTextField: UITextField!
    
    @IBOutlet weak var mailTextField: UITextField!
    
    var prenom : String = "";
    var nom : String = "";
    var mail : String = "";

    
    @IBOutlet weak var anneePicker: UIPickerView!
    
    var anneePickerData: [Int] = []
    
    
    //MARK: - UIViewController function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prenomTextField.delegate = self
        nomTextField.delegate = self
        mailTextField.delegate = self
        
        //anneePicker.delegate = self
        
        /*do
        {
            let anneePromo = try AnneeModel.getToutesLesAnnees()
            for annee in anneePromo
            {
                anneePickerData.append(Int(annee.annee))
            }
        }
        catch let error as NSError
        {
            DialogBoxHelper.alert(view : self, error: error)
        }*/
        
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
        self.textFieldDidEndEditing(prenomTextField)
        
        var verif: Bool = true
        if (self.nom=="")
        {
            self.nomTextField.placeholder = "REMPLISSEZ CE CHAMP SVP"
            self.nomTextField.backgroundColor = UIColor.red
            verif = false
        }
        if (self.prenom=="")
        {
            self.prenomTextField.placeholder = "REMPLISSEZ CE CHAMP SVP"
            self.prenomTextField.backgroundColor = UIColor.red
            verif = false
        }
        if (self.mail=="")
        {
            self.mailTextField.placeholder = "REMPLISSEZ CE CHAMP SVP"
            self.mailTextField.backgroundColor = UIColor.red
            verif = false
        }
        if (verif)
        {
            do
            {
                try UtilisateurModel.insertUtilisateur(mail: self.mail, nom: self.nom, prenom: self.prenom)
            }
            catch let error as NSError
            {
                DialogBoxHelper.alert(view : self, error: error)
            }
        }
        
       return verif
    }
    
    
    
    //MARK: - UITextFieldDelegate Functions
    
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

    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.nomTextField.backgroundColor = UIColor.white
        self.prenomTextField.backgroundColor = UIColor.white
        self.mailTextField.backgroundColor = UIColor.white
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
    
    
    //MARK: - UIPickerViewDelegate Functions
    
    /**func numberOfComponents(in pickerView: UIPickerView) -> Int {
        <#code#>
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return
    }**/

    
    

}
