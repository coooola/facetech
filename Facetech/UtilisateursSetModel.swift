//
//  UtilisateursSetModel.swift
//  Facetech
//
//  Created by Nicolas BITAN on 08/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
import CoreData

class UtilisateursSetModel : NSObject{

    
    static var utilisateursSet = {
        return UtilisateursSetModel()
    }()
    
    

    private override init() {}
    
    
    /// - Description:
    /// Permet de créer un utilisateur
    /// - Parameters:
    ///   - mail: mail de l'utilisateur
    ///   - nom: nom de l'utilisateur
    ///   - prenom: prénom de l'utilisateur
    /// - Returns: l'utilisateur créé
    /// - Throws: retourne une erreur en cas d'erreur au moment de la sauvegard de l'objet créé
    func insertUtilisateur(mail: String, nom: String, prenom: String) throws -> Utilisateur
    {
        let newUser = Utilisateur.createUtilisateur(mail: mail, nom: nom, prenom: prenom)

        if let error = CoreDataManager.save()
        {
            throw error
        }
    
        return newUser        
    }
    
    
    
    
    
    func getUtilisateur(mail: String? = nil, nom: String? = nil, prenom: String? = nil) throws -> Utilisateur?
    {
        
        let context = CoreDataManager.context
        
        var user : [Utilisateur] = []
        
        let request : NSFetchRequest<Utilisateur> = Utilisateur.fetchRequest()
        
        request.predicate = NSPredicate(format: "adresseMail == %@", mail != nil ? mail! : "")
        
        do
        {
            try user = context.fetch(request)
        }
        catch let error as NSError{
            throw error
        }
        
        return user.count != 0 ? user[0]: nil
        
    }
 
    
    
    
    
    
    
    func getUtilisateurById(id: Int) throws -> Utilisateur?
    {
        
        let context = CoreDataManager.context
        
        var user : Utilisateur? = nil
        
        let request : NSFetchRequest<Utilisateur> = Utilisateur.fetchRequest()
        
        request.predicate = NSPredicate(format: "idUtilisateur == %@", id)
        
        do
        {
            try user = context.fetch(request).first
        }
        catch let error as NSError{
            throw error
        }
        
        return user
        
    }
}
