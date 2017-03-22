//
//  MessagesSetModel.swift
//  Facetech
//
//  Created by Julia Favrel on 15/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
import CoreData


class MessageSetModel: NSObject {

    /// Description :
    /// Permet de créer un nouveau message et de l'ajouter dans la base de donées
    /// - Parameter contenu: le contenu du message
    /// - Returns: le message créé
    /// - Throws: erreur encontrée
    func insertMessage(contenu: String) throws -> Message
    {
        let newMessage = Message.createMessage(contenu: contenu)
        
        if let error = CoreDataManager.save()
        {
            throw error
        }
        return newMessage
    }
    
    
    /// Description
    ///
    /// - Parameter contenu: <#contenu description#>
    /// - Returns: <#return value description#>
    /// - Throws: <#throws value description#>
    /*func getMessageByUserType(userType: TypeUtilisateur? = nil) throws -> Message?
    {
        
        let context = CoreDataManager.context
        
        var msg : [Message] = []
        
        let request : NSFetchRequest<Message> = Message.fetchRequest()
        
        request.predicate = NSPredicate(format: "Utilisateur.etreEcritPar == %@", userType)

    
        do
        {
            try msg = context.fetch(request)
        }
        catch let error as NSError{
            throw error
        }
        
        return msg.count != 0 ? msg[0]: nil
        
    }*/
    


}
