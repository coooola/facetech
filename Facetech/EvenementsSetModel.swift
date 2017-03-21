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
    
    
    static var evenementSet = {
        return EvenementsSetModel()
    }()
    
    
    private var tousLesEvenements: [Evenement] = []
    
    
    
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
