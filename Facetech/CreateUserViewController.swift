//
//  CreateUserViewController.swift
//  Facetech
//
//  Created by Nicolas BITAN on 02/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit
import CoreData

class CreateUserViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate
{

    
    //MARK: - Objects
    
    //MARK: Textfield
    
    @IBOutlet weak var prenomTextField: UITextField!
    
    @IBOutlet weak var nomTextField: UITextField!
    
    @IBOutlet weak var mailTextField: UITextField!
    
    var prenom : String = "";
    var nom : String = "";
    var mail : String = "";
    
    //MARK: Picker
    
    @IBOutlet weak var anneePicker: UIPickerView!
    
    
    @IBOutlet weak var typeUtilisateurPicker: UIPickerView!
    
    
    
    //MARK: - UIViewController function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prenomTextField.delegate = self
        nomTextField.delegate = self
        mailTextField.delegate = self
        
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
            self.mailTextField.placeholder = "FORMAT DU MAIL : christophe.fiorio@facetech.fr"
            self.mailTextField.backgroundColor = UIColor.red
            verif = false
        }
        if (!isValidEmail(testStr: self.mail) )
        {
            self.mailTextField.backgroundColor = UIColor.red
            verif = false
        }
        do
        {
            if (try UtilisateursSetModel.utilisateursSet.getUtilisateurByMail(mail: self.mail) != nil)
            {
                self.mailTextField.text = ""
                self.mailTextField.placeholder = "MAIL DEJA PRIS"
                self.mailTextField.backgroundColor = UIColor.red
                verif = false
            }
        }
        catch let error as NSError
        {
            DialogBoxHelper.alert(view : self, error: error)
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
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        do
        {
            if (pickerView == typeUtilisateurPicker)
            {
                return try TypeUtilisateursSetModel.typeUtilisateurSet.getTousLesTypesUtilisateurs().count
            }
                
            else
            {
                return try AnneesSetModel.anneesSet.getToutesLesAnnees().sorted(by: { $0.annee < $1.annee}).count
            }
        }
        catch let error as NSError
        {
            DialogBoxHelper.alert(view : self, error: error)
        }
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        do
        {
            if (pickerView == typeUtilisateurPicker)
            {
                try anneePicker.isHidden = (TypeUtilisateursSetModel.typeUtilisateurSet.getTousLesTypesUtilisateurs()[typeUtilisateurPicker.selectedRow(inComponent: 0)].libelleTypeUtilisateur != "Etudiant")
                return try TypeUtilisateursSetModel.typeUtilisateurSet.getTousLesTypesUtilisateurs()[row].libelleTypeUtilisateur
                
            }
            else
            {
                return try AnneesSetModel.anneesSet.getToutesLesAnnees().sorted(by: { $0.annee < $1.annee})[row].annee.description
            }
        }
        catch let error as NSError
        {
            DialogBoxHelper.alert(view : self, error: error)
        }
        return nil
    }
    
    
    //MARK: - Validation function
    
    
    /// Indique la validité d'un email
    ///
    /// - Parameter testStr: string à validé
    /// - Returns: return vrai si le string en paramètre est un email, faux sinon.
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    

}
