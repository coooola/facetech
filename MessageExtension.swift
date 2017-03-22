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
    
    static func createMessage(contenu: String) -> Message
    {
        let newMessage = Message(context : CoreDataManager.context)
        newMessage.contenu = contenu
        CoreDataManager.save()
        return newMessage
        
    }
    
    
    
    
}

