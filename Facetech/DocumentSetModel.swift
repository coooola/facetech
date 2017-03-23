//
//  DocumentSetModel.swift
//  Facetech
//
//  Created by Julia Favrel on 23/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
import CoreData

class DocumentSetModel: NSObject {

    /// Instance et instanciation du singleton afin d'assurer l'unicité de la variable privée suivante
    static var documentSet = {
        return DocumentSetModel()
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
    lazy var tousLesDocuments: NSFetchedResultsController<Document> = {
        let request : NSFetchRequest<Document> = Document.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Document.dateCreationDocument), ascending: false)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: #keyPath(Document.dateCreationDocument), cacheName: nil)
        
        fetchResultController.delegate = viewController
        
        return fetchResultController
    }()
    
    
    
    /// Crée un événement
    ///
    /// - Parameters:
    ///   - nom: Nom de l'événement
    ///   - date: Date et heure de l'évenement
    /// - Returns: L'événement créé
    /// - Throws: Erreur dans la création
    func insertDocument(nomDoc: String, urlDoc: String, date: Date) throws -> Document
    {
        let newDoc = Document.createDocument(nomDocument: nomDoc, urlDocument: urlDoc, dateCreationDocument: date)
        
        if let error = CoreDataManager.save()
        {
            throw error
        }
        
        //tousLesDocuments.append(newDoc)
        
        return newDoc
    }

    
}
