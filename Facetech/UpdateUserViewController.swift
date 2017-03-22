//
//  UpdateUserViewController.swift
//  Facetech
//
//  Created by Nicolas BITAN on 22/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit
import CoreData

class UpdateUserViewController: UIViewController, UITextFieldDelegate
{
    
    
    @IBOutlet weak var ancienMotDePasseTextField: UITextField!
    
    @IBOutlet weak var nouveauMotDePasseTextField: UITextField!
    
    @IBOutlet weak var confirmationNouveauMotDePasseTextFied: UITextField!
    
    
    //MARK: - UIViewController function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Update User functions
    
    @IBAction func updateUser(_ sender: Any)
    {
        let message : (String,String) = genereMessageModificationMotDePasse()
        
        let alert = UIAlertController(title: message.0,
                                      message: message.1,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok",
                                        style: .default)

        alert.addAction(okAction)
        
        present(alert, animated: true)
        
    }
    
    
    /// Retourne une indication sur l'égalité des nouveaux mot de passer
    ///
    /// - Returns: Vrai si les nouveaux mot de passe correspondent, faux sinon
    func checkNouveauxMotDePasses() -> Bool
    {
        return (nouveauMotDePasseTextField.text == confirmationNouveauMotDePasseTextFied.text)
    }
    
    
    /// Retourne une vérification sur l'ancien mot de passe.
    ///
    /// - Parameter ancienMotDePasse: ancien mot de passe
    /// - Returns: Vrai si le mot de passe rentré correspond à l'ancien mot de passe
    func checkAncienMotDePasse(ancienMotDePasse : String) -> Bool
    {
        return (ancienMotDePasseTextField.text  == ancienMotDePasse)
    }
    
    
    
    /// Vérifie les mot de passes rentrés par l'utilisateur.
    /// Enregistre le nouveau mot de passe si tout est ok.
    /// Génére les messages à afficher à l'utilisateur en fonction du résultat.
    ///
    /// - Returns: titre et message d'erreur à afficher
    func genereMessageModificationMotDePasse() -> (String,String)
    {
        let connectedUser : Utilisateur = Session.utilisateurConnecte!
    
        var message : String = "Votre mot de passe a été mis à jour avec succés."
        var title : String = "Mot de passe modifié !"
    
        if (checkNouveauxMotDePasses())
        {
            if (checkAncienMotDePasse(ancienMotDePasse: connectedUser.motDePasse!))
            {
                if ((nouveauMotDePasseTextField.text?.characters.count)! > 5)
                {
                    connectedUser.motDePasse = nouveauMotDePasseTextField.text
                    do
                    {
                        _  = try UtilisateursSetModel.utilisateursSet.updateUtilisateur(user: connectedUser)
                    }
                    catch let error as NSError
                    {
                        DialogBoxHelper.alert(view : self, error: error)
                    }
                }
                else{
                    message = "Votre mot de passe doit faire au moins 6 caractères"
                    title = "Mot de passe trop petit"
                }
            }
            else{
                message = "Votre mot de passe est incorrect."
                title = "Mot de passe incorrect"
            }
    
        }
        else
        {
            message = "Erreur lors de la mise à jour du mot de passe. Les mots de passe ne correspondent pas."
            title = "Mots de passe différents"
        }
        
        return (title, message)
    }
    
    
    //MARK: - Disconnect User functions
    
    /// Déconnecte l'utilisateur
    ///
    /// - Parameter sender: bouton de déconnexion
    @IBAction func disconnect(_ sender: Any) {
        Session.session.disconnectUser()
    }
    
    
    
}
