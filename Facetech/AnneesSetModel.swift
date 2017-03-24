//
//  AnneesSetModel.swift
//  Facetech
//
//  Created by Nicolas BITAN on 08/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
import CoreData

class AnneesSetModel : NSObject{
    
    /// Instance et instanciation du singleton afin d'assurer l'unicité de la variable privée suivante
    static var anneesSet = {
        return AnneesSetModel()
    }()
    
    /// Override de l'init pour éviter les instanciations externes.
    private override init() {}
    
    /// Variable privée contenant toutes les années de promotion.
    private var touteLesAnnees : [AnneePromo] = []
    
    
    
    /// Retourne un tableau contenant toutes les années de promotion
    ///
    /// - Returns: tableau des années de promo
    /// - Throws: exception si une erreur pendant la requête
    func getToutesLesAnnees() throws -> [AnneePromo]
    {
        if (touteLesAnnees.count == 0)
        {
            let context = CoreDataManager.context
        
            let request : NSFetchRequest<AnneePromo> = AnneePromo.fetchRequest()
        
            do
            {
                try touteLesAnnees = context.fetch(request)
                
                if (touteLesAnnees.count == 0)
                {
                    let an1 : AnneePromo = AnneePromo(context : CoreDataManager.context)
                    an1.annee = 3
                    
                    let an2 : AnneePromo = AnneePromo(context : CoreDataManager.context)
                    an2.annee = 4
                    
                    let an3 : AnneePromo = AnneePromo(context : CoreDataManager.context)
                    an3.annee = 5
                    
                    CoreDataManager.save()
                    
                    try touteLesAnnees = context.fetch(request)
                }
                
                
            }
            catch let error as NSError{
                throw error
            }
        }
        
        return touteLesAnnees
    }
    
    
    
    func getAnne(anne: Int) throws -> AnneePromo?
    {
        if (anne < 3 || anne > 5)
        {
            return nil
        }
        return try getToutesLesAnnees().sorted(by: { $0.annee < $1.annee})[(anne - 3)]
        
    }

}
    
