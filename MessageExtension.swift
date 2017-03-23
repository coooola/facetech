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
    
    static func createMessage(etreEcritPar: Utilisateur, contenu: String, typesUtilisateurs : [TypeUtilisateur])
    {
        let newMessage = Message(context : CoreDataManager.context)
        newMessage.etreEcritPar = etreEcritPar
        newMessage.contenu = contenu
        newMessage.datePost = NSDate()
        for i in typesUtilisateurs {
            newMessage.addToEtreLieTypeUtilisateur(i)
        }
        
        
        CoreDataManager.save()
    }
    
    
    static func deleteMessage(message : Message)
    {
        CoreDataManager.context.delete(message)
    }
    
    /*static func getDate() -> String
    {
        let dateMsg = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy'T'HH:mm:ssZ"
        let s = dateFormatter.string(from: dateMsg as Date)
        return s
    }*/
    
    var time: String {
        get {
            if (self.datePost != nil)
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss"
                let convertedDate = dateFormatter.string(from: self.datePost as! Date)
                return convertedDate
            }
            else
            {
                return "00:00:00"
            }
        }
    }
    
    var date: String {
        get {
            if (self.datePost != nil)
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let convertedDate = dateFormatter.string(from: self.datePost as! Date)
                return convertedDate
            }
            else
            {
                return "Date Inconnue"
            }
        }
    }
    
    
}

