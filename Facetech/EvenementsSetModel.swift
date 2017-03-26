//
//  EvenementsSetModel.swift
//  Facetech
//
//  Created by Polytech on 19/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
import CoreData


class EvenementsSetModel: NSObject
{
    
    
    /// Instance et instanciation du singleton afin d'assurer l'unicité de la variable privée suivante
    static var evenementSet = {
        return EvenementsSetModel()
    }()
    
    /// Override de l'init pour éviter les instanciations externes.
    private override init() {}
    
    
    static private var pViewController : NSFetchedResultsControllerDelegate? = nil
    
    
    static var viewController : NSFetchedResultsControllerDelegate? {
        get{
            return self.pViewController
        }
        set{
            if self.pViewController == nil{
                self.pViewController = newValue
            }
        }
    }
    
    /// Variable privée contenant tous les événements.
    lazy var tousLesEvenements: NSFetchedResultsController<Evenement> =
    {
        let request : NSFetchRequest<Evenement> = Evenement.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Evenement.dateEvenement), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: #keyPath(Evenement.date), cacheName: nil)
        fetchResultController.delegate = viewController
        
        return fetchResultController
    }()
    
    func getTousEvent() -> NSFetchedResultsController<Evenement> {
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
        
        //tousLesEvenements.append(newEvent)
        
        return newEvent
    }
    
    
}
