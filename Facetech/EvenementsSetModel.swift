//
//  EvenementsSetModel.swift
//  Facetech
//
//  Created by Polytech on 19/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
import CoreData


class EvenementsSetModel: NSObject{
    
    
    /// Instance et instanciation du singleton afin d'assurer l'unicité de la variable privée suivante
    static var evenementSet = {
        return EvenementsSetModel()
    }()
    
    /// Override de l'init pour éviter les instanciations externes.
    private override init() {}
    
    /// Variable privée contenant tous les événements.
    private var tousLesEvenements: [Evenement] = []
    
    
    /// Récupére l'ensemble des événements
    ///
    /// - Returns: tableau des évenements
    /// - Throws: erreur dans la requête
    func getTousLesEvenements() throws -> [Evenement]
    {
        if (tousLesEvenements.count == 0)
        {
            let context = CoreDataManager.context
            
            let request : NSFetchRequest<Evenement> = Evenement.fetchRequest()
            
            do
            {
                try tousLesEvenements = context.fetch(request)
            }
            catch let error as NSError{
                throw error
            }
        }
        
        return tousLesEvenements
    }
    
    
    
    /// Crée un événement
    ///
    /// - Parameters:
    ///   - nom: Nom de l'événement
    ///   - date: Date et heure de l'évenement
    /// - Returns: L'événement créé
    /// - Throws: Erreur dans la création
    func insertEvenement(nom: String, date: Date) throws -> Evenement
    {
        let newEvent = Evenement.createEvenement(nom: nom, date: date)
        
        if let error = CoreDataManager.save()
        {
            throw error
        }
        
        tousLesEvenements.append(newEvent)
        
        print("Insertion de l'évenement réussi !")
        
        
        return newEvent
    }
    
}
