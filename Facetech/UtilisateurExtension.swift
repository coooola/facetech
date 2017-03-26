//
//  Utilisateur.swift
//  Facetech
//
//  Created by Nicolas BITAN on 08/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
import CoreData

extension Utilisateur{
    
    
    /// Crée un utilisateur
    ///
    /// - Parameters:
    ///   - mail: Mail de l'utilisateur
    ///   - nom: Nom de l'utilisateur
    ///   - prenom: Prénom de l'utilisateur
    ///   - annee: Année de promotion de l'utilisateur
    ///   - typeUtilisateur: Type d'utilisateur
    /// - Returns: L'utilisateur créé
    static func createUtilisateur(mail: String, nom: String, prenom: String, annee: AnneePromo?, typeUtilisateur: TypeUtilisateur) -> Utilisateur
    {
        let newUser = Utilisateur(context : CoreDataManager.context)
        newUser.adresseMail = mail
        newUser.nom = nom
        newUser.prenom = prenom
        newUser.motDePasse = prenom + "." + nom
        if (annee != nil)
        {
            newUser.appartenirPromo = annee
        }
        newUser.possederTypeUtilisateur = typeUtilisateur
        
        return newUser
        
    }
    
    /// Supprime un utilisateur de la base de données
    ///
    /// - Parameter utilisateur: l'utilisateur à supprimer
    static func deleteUtilisateur(utilisateur : Utilisateur)
    {
        CoreDataManager.context.delete(utilisateur)
    }
    
    

    
}
