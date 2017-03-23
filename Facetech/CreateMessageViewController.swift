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
    
    /// Action effectuée lors de l'appuie sur le bouton ’Envoyer’ de la vue de création d'un message.
    /// Cette action permet d'ajouter un message en appelant les différentes methodes necessaires
    ///
    /// - Parameter sender: sender button
    @IBAction func addMessage(_ sender: UIButton) {
        
        let msg = self.msgText.text
        
        //Créé le message si l'utilisateur est connecté et le message non vide
        if (msg != nil && Session.utilisateurConnecte != nil){
            
            //Recupere les utilisateurs destinataires du message dans la variable
            let typesUsers : [TypeUtilisateur] = getTypesUtilisateurMsg(toSecretaires: secretairesSwitch.isOn, toProfesseurs: professeursSwitch.isOn, toResponsables: responsablesSwitch.isOn, toTroisA: troisASwitch.isOn, toQuatreA: quatreASwitch.isOn, toCinqA: cinqASwitch.isOn)

            Message.createMessage(etreEcritPar: Session.utilisateurConnecte!, contenu: msg!, typesUtilisateurs : typesUsers)
            
            self.msgText.text=nil
        }
        else{
            DialogBoxHelper.alertEmpty(view: self)
        }
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
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
