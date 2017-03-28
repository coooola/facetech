//
//  CreateMessageViewController.swift
//  Facetech
//
//  Created by Julia Favrel on 23/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit

class CreateMessageViewController: UIViewController {

    @IBOutlet weak var msgText: UITextView!
    @IBOutlet weak var secretairesSwitch: UISwitch!
    @IBOutlet weak var professeursSwitch: UISwitch!
    @IBOutlet weak var troisASwitch: UISwitch!
    @IBOutlet weak var quatreASwitch: UISwitch!
    @IBOutlet weak var responsablesSwitch: UISwitch!
    @IBOutlet weak var cinqASwitch: UISwitch!
    
    /// Action effectuée lors de l'appuie sur le bouton ’Annuler’ de la vue de création d'un message.
    /// Cette action permet d'annuler l'ajout d'un message en appelant les différentes methodes necessaires
    ///
    /// - Parameter sender: sender button
    @IBAction func cancelAdd(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }

    /// Permet de récuperer des types d'utilisateur en fonction de booleens recupéré grâce aux switch
    ///
    /// - Parameters:
    ///   - toSecretaires: true si le switch est activé
    ///   - toProfesseurs: true si le switch est activé
    ///   - toResponsables: true si le switch est activé
    ///   - toTroisA: true si le switch est activé
    ///   - toQuatreA: true si le switch est activé
    ///   - toCinqA: true si le switch est activé
    /// - Returns: return un tableau de types d'utilisateurs représentants les utilisateurs à qui le message doit etre envoyé
    func getTypesUtilisateurMsg() -> [TypeUtilisateur]
    {
        
        var typesUtilisateurs : [TypeUtilisateur] = []
        
        do{
            if secretairesSwitch.isOn {
                try typesUtilisateurs.append(TypeUtilisateursSetModel.typeUtilisateurSet.getTypeUtilisateur(name: "Secrétaire")!)
            }
            if professeursSwitch.isOn {
                try typesUtilisateurs.append(TypeUtilisateursSetModel.typeUtilisateurSet.getTypeUtilisateur(name: "Enseignant")!)
            }
            if responsablesSwitch.isOn {
                try typesUtilisateurs.append(TypeUtilisateursSetModel.typeUtilisateurSet.getTypeUtilisateur(name: "Responsable")!)
            }
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        
        return typesUtilisateurs
        
    }
    
    func getAnneePromo() -> [AnneePromo]
    {
        var annees : [AnneePromo] = []
        do{
            if troisASwitch.isOn {
                try annees.append(AnneesSetModel.anneesSet.getAnne(anne: 3)!)
            }
            if quatreASwitch.isOn {
                try annees.append(AnneesSetModel.anneesSet.getAnne(anne: 4)!)
            }
            if cinqASwitch.isOn {
                try annees.append(AnneesSetModel.anneesSet.getAnne(anne: 5)!)           }
            
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        return annees
    }
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
     /// <#Description#>
     ///
     /// - Parameters:
     ///   - identifier: <#identifier description#>
     ///   - sender: <#sender description#>
     /// - Returns: <#return value description#>
     override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool
     {

        if (self.msgText.text=="")
        {
            self.msgText.backgroundColor = UIColor.red
            return false
        }
        if (!cinqASwitch.isOn && !quatreASwitch.isOn && !troisASwitch.isOn && !professeursSwitch.isOn && !responsablesSwitch.isOn && !secretairesSwitch.isOn)
        {
            self.msgText.backgroundColor = UIColor.red
            return false
        }
        return true
     
     }


}
