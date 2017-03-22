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
    
    var anneePickerData: [AnneePromo] = []
    
    @IBOutlet weak var typeUtilisateurPicker: UIPickerView!
    
    var typeUtilisateurData: [TypeUtilisateur] = []
    
    
    //MARK: - UIViewController function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prenomTextField.delegate = self
        nomTextField.delegate = self
        mailTextField.delegate = self
        
        /**let an1 : AnneePromo = AnneePromo(context : CoreDataManager.context)
        an1.annee = 3
        
        let an2 : AnneePromo = AnneePromo(context : CoreDataManager.context)
        an2.annee = 4
        
        let an3 : AnneePromo = AnneePromo(context : CoreDataManager.context)
        an3.annee = 5
        
        let us1 : TypeUtilisateur = TypeUtilisateur(context : CoreDataManager.context)
        us1.idTypeUtilisateur = 1
        us1.libelleTypeUtilisateur = "Etudiant"
        
        let us2 : TypeUtilisateur = TypeUtilisateur(context : CoreDataManager.context)
        us2.idTypeUtilisateur = 2
        us2.libelleTypeUtilisateur = "Enseignant"
        
        let us3 : TypeUtilisateur = TypeUtilisateur(context : CoreDataManager.context)
        us3.idTypeUtilisateur = 3
        us3.libelleTypeUtilisateur = "Resposable du département"
        
        let us4 : TypeUtilisateur = TypeUtilisateur(context : CoreDataManager.context)
        us4.idTypeUtilisateur = 4
        us4.libelleTypeUtilisateur = "Secrétaire"
        
        
        CoreDataManager.save()**/
        
        
        do
        {
            anneePickerData = try AnneesSetModel.anneesSet.getToutesLesAnnees().sorted(by: { $0.annee < $1.annee})
            typeUtilisateurData = try TypeUtilisateursSetModel.typeUtilisateurSet.getTousLesTypesUtilisateurs()
        }
        catch let error as NSError
        {
            DialogBoxHelper.alert(view : self, error: error)
        }
        
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
                try UtilisateursSetModel.utilisateursSet.insertUtilisateur(mail: self.mail, nom: self.nom, prenom: self.prenom)
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if (pickerView == typeUtilisateurPicker)
        {
            return typeUtilisateurData.count
        }
        
        else
        {
            return anneePickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if (pickerView == typeUtilisateurPicker)
        {
            return typeUtilisateurData[row].libelleTypeUtilisateur
        }
        else
        {
            return anneePickerData[row].annee.description
        }
    }
    
    
    

}
