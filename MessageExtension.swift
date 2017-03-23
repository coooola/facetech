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
    
    /// Creer un nouveau message dans la base de données
    ///
    /// - Parameters:
    ///   - etreEcritPar: l'utilisateur qui écrit le message, récupéré grâce à la session
    ///   - contenu: contenu du message
    ///   - typesUtilisateurs: les types utilisateurs auquels est envoyé le message
    static func createMessage(etreEcritPar: Utilisateur, contenu: String, typesUtilisateurs : [TypeUtilisateur], anneesPromo : [AnneePromo])
    {
        let newMessage = Message(context : CoreDataManager.context)
        newMessage.etreEcritPar = etreEcritPar
        newMessage.contenu = contenu
        newMessage.datePost = NSDate()
        
        for i in typesUtilisateurs {
            newMessage.addToEtreLieTypeUtilisateur(i)
            print(i)
        }
        for j in anneesPromo {
            newMessage.addToEtreLieAnne(j)
            print(j)
        }
        CoreDataManager.save()
    }
    
    
    /// Supprime un message de la base de données
    ///
    /// - Parameter message: le message à supprimer
    static func deleteMessage(message : Message)
    {
        CoreDataManager.context.delete(message)
    }
    
    // Retourne l'heure du message sous forme de String
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
    
    // Retourne la date du message sous forme de string 
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

