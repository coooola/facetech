//
//  MesagesSetModel.swift
//  Facetech
//
//  Created by Nicolas BITAN on 23/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
import CoreData


class MesagesSetModel: NSObject
{
    
    /// Instance et instanciation du singleton afin d'assurer l'unicité de la variable privée suivante
    static var messageSet = {
        return MesagesSetModel()
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
    lazy var tousLesMessages: NSFetchedResultsController<Message> =
        {
                print("JE PASSE DANS LE FETCH")
        let request : NSFetchRequest<Message> = Message.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Message.datePost), ascending: false)]
        if (Session.utilisateurConnecte?.appartenirPromo == nil)
        {
            request.predicate = NSPredicate(format: "ANY etreLieTypeUtilisateur == %@ OR etreEcritPar == %@", (Session.utilisateurConnecte?.possederTypeUtilisateur)!, Session.utilisateurConnecte!)
        }
        else
        {
            request.predicate = NSPredicate(format: "ANY etreLieTypeUtilisateur == %@ OR ANY etreLieAnne == %@ OR etreEcritPar == %@", (Session.utilisateurConnecte?.possederTypeUtilisateur)!, (Session.utilisateurConnecte?.appartenirPromo)!, Session.utilisateurConnecte!)
        }
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: #keyPath(Message.date), cacheName: nil)
        
        fetchResultController.delegate = viewController
        
        return fetchResultController
    }()
    
    
    
}
