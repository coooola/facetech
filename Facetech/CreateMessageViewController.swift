//
//  CreateMessageViewController.swift
//  Facetech
//
//  Created by Julia Favrel on 22/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit

class CreateMessageViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextView!
    
    @IBOutlet weak var cinqASwitch: UISwitch!
    @IBOutlet weak var quatreASwitch: UISwitch!
    @IBOutlet weak var troisASwitch: UISwitch!
    @IBOutlet weak var responsablesSwitch: UISwitch!
    @IBOutlet weak var professeursSwitch: UISwitch!
    @IBOutlet weak var secretairesSwitch: UISwitch!
    
    @IBAction func addMessage(_ sender: Any) {
        let msg = self.messageTextField.text
        
        if (msg != nil && Session.utilisateurConnecte != nil){
            
            
            let typesUsers : [TypeUtilisateur] = getTypesUtilisateurMsg(toSecretaires: secretairesSwitch.isOn, toProfesseurs: professeursSwitch.isOn, toResponsables: responsablesSwitch.isOn, toTroisA: troisASwitch.isOn, toQuatreA: quatreASwitch.isOn, toCinqA: cinqASwitch.isOn)
            
            
            Message.createMessage(etreEcritPar: Session.utilisateurConnecte!, contenu: msg!, typesUtilisateurs : typesUsers)
            
            self.messageTextField.text=nil
        }
        else{
            DialogBoxHelper.alertEmpty(view: self)
        }
        
        //self.messageTable.reloadData()
        
        
    }
    
    
    func getTypesUtilisateurMsg(toSecretaires: Bool, toProfesseurs: Bool, toResponsables: Bool, toTroisA: Bool, toQuatreA: Bool, toCinqA: Bool) -> [TypeUtilisateur]
    {
        
        var typesUtilisateurs : [TypeUtilisateur] = []
        
        do{
            if toSecretaires {
                try typesUtilisateurs.append(TypeUtilisateursSetModel.typeUtilisateurSet.getTypeUtilisateur(name: "Secrétaire")!)
            }
            if toProfesseurs {
                try typesUtilisateurs.append(TypeUtilisateursSetModel.typeUtilisateurSet.getTypeUtilisateur(name: "Enseignant")!)
            }
            if toResponsables {
                try typesUtilisateurs.append(TypeUtilisateursSetModel.typeUtilisateurSet.getTypeUtilisateur(name: "Resposable du département")!)
            }
            if toTroisA {
                try typesUtilisateurs.append(TypeUtilisateursSetModel.typeUtilisateurSet.getTypeUtilisateur(name: "Secrétaire")!)
            }
            if toQuatreA {
                try typesUtilisateurs.append(TypeUtilisateursSetModel.typeUtilisateurSet.getTypeUtilisateur(name: "Secrétaire")!)
            }
            if toCinqA {
                try typesUtilisateurs.append(TypeUtilisateursSetModel.typeUtilisateurSet.getTypeUtilisateur(name: "Secrétaire")!)
            }
            
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
        }
        
        return typesUtilisateurs
    
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var createMessage: UIButton!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
