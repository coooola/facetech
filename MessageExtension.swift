//
//  MessageExtension.swift
//  Facetech
//
//  Created by Julia Favrel on 15/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
import CoreData

extension Message{
    
    static func createMessage(etreEcritPar: Utilisateur, contenu: String)
    {
        let newMessage = Message(context : CoreDataManager.context)
        newMessage.etreEcritPar = etreEcritPar
        newMessage.contenu = contenu
        newMessage.datePost = NSDate()
        
        CoreDataManager.save()
    }
    
    static func deleteMessage(message : Message)
    {
        CoreDataManager.context.delete(message)
    }
    
    
}

