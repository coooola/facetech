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
    
    static var anneesSet = {
        return AnneesSetModel()
    }()
    
    
    private var touteLesAnnees : [AnneePromo] = []
    
    
    
    func getToutesLesAnnees() throws -> [AnneePromo]
    {
        if (touteLesAnnees.count == 0)
        {
            let context = CoreDataManager.context
        
            let request : NSFetchRequest<AnneePromo> = AnneePromo.fetchRequest()
        
            do
            {
                try touteLesAnnees = context.fetch(request)
            }
            catch let error as NSError{
                throw error
            }
        }
        
        return touteLesAnnees
    }
}
    
