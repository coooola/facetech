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
    
    /// Variable privée contenant tous les documents.
    lazy var tousLesDocuments: NSFetchedResultsController<Document> = {
        let request : NSFetchRequest<Document> = Document.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Document.dateCreationDocument), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: #keyPath(Document.date), cacheName: nil)
        fetchResultController.delegate = viewController
        
        return fetchResultController
    }()
    
    /// Crée un Document
    ///
    /// - Parameters:
    ///   - nom: Nom du document
    ///   - url: Url du document
    /// - Returns: Le document créé
    /// - Throws: Erreur dans la création
    func insertDocument(nomdoc: String, urldoc: String) throws -> Document
    {
        let newDoc = Document.createDocument(nom: nomdoc, url: urldoc)
        
        if let error = CoreDataManager.save()
        {
            throw error
        }
        
        //tousLesEvenements.append(newEvent)
        
        return newDoc
    }
    
}

    

