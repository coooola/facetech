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
    
    
    @IBOutlet weak var createUser: UIButton!
    
    @IBOutlet weak var ancienMotDePasseTextField: UITextField!
    
    @IBOutlet weak var nouveauMotDePasseTextField: UITextField!
    
    @IBOutlet weak var confirmationNouveauMotDePasseTextFied: UITextField!
    
    @IBOutlet weak var prenomLable: UILabel!
    
    @IBOutlet weak var nomLabel: UILabel!
    
    @IBOutlet weak var groupeLabel: UILabel!
    
    
    //MARK: - UIViewController function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Si l'utilisateur est un secrétaire, le bouton ajouter un utilisateur est visible, sinon il est caché
        createUser.isHidden = true
        if (Session.utilisateurConnecte?.possederTypeUtilisateur?.libelleTypeUtilisateur == "Secrétaire"){
            createUser.isHidden = false
        }
        
        // Affiche les informations de l'utilisateur
        prenomLable.text = Session.utilisateurConnecte?.prenom
        nomLabel.text = Session.utilisateurConnecte?.nom
        
        let utilisateur = Session.utilisateurConnecte?.possederTypeUtilisateur?.libelleTypeUtilisateur
        
        if (utilisateur == "Etudiant"){
            
            let annee = Session.utilisateurConnecte?.appartenirPromo?.annee
            groupeLabel.text = utilisateur! + " " + (annee?.description)! + "A"
        }
        else{
            groupeLabel.text = utilisateur
        }
        
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
    @IBAction func disconnect(_ sender: Any)
    {
        Session.session.disconnectUser()
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Create User functions
    
    
    /// crée l'utilisateur après le retour sur l'écran d'update utilisateur
    ///
    /// - Parameter segue: CreateUserViewController
    @IBAction func unwindToUpdateUserAfterAddingNewUser(segue: UIStoryboardSegue)
    {
        let createViewController = segue.source as! CreateUserViewController
        do
        {

            var annee : AnneePromo? = nil
                    if (try TypeUtilisateursSetModel.typeUtilisateurSet.getTousLesTypesUtilisateurs()[createViewController.typeUtilisateurPicker.selectedRow(inComponent: 0)] == TypeUtilisateursSetModel.typeUtilisateurSet.getTypeUtilisateur(name: "Etudiant"))
                    {
                        annee = try AnneesSetModel.anneesSet.getToutesLesAnnees().sorted(by: { $0.annee < $1.annee})[createViewController.anneePicker.selectedRow(inComponent: 0)]
                    }
                    _ = try UtilisateursSetModel.utilisateursSet.insertUtilisateur(mail: createViewController.mail, nom: createViewController.nom, prenom: createViewController.prenom, annee: annee, typeUtilisateur: TypeUtilisateursSetModel.typeUtilisateurSet.getTousLesTypesUtilisateurs()[createViewController.typeUtilisateurPicker.selectedRow(inComponent: 0)])

        }
        catch let error as NSError
        {
            DialogBoxHelper.alert(view : self, error: error)
        }

    }
    
    
    
    
}
