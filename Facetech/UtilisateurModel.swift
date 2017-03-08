//
//  UtilisateurModel.swift
//  Facetech
//
//  Created by Nicolas BITAN on 08/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
import CoreData

class UtilisateurModel : NSObject{
    
    class func insertUtilisateur(mail: String, nom: String, prenom: String) throws -> Utilisateur
    {
        
        let context = CoreDataManager.context
        
        let newUser = Utilisateur.createUtilisateur(context: context, mail: mail, nom: nom, prenom: prenom)

        if let error = CoreDataManager.save()
        {
            throw error
        }
    
        return newUser
        
    }
    
    
    class func getUtilisateur(mail: String? = nil, nom: String? = nil, prenom: String? = nil) throws -> Utilisateur?
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
    
}
