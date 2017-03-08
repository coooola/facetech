//
//  AnneeModel.swift
//  Facetech
//
//  Created by Nicolas BITAN on 08/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
import CoreData

class AnneeModel : NSObject{
    
    
    class func getToutesLesAnnees() throws -> [AnneePromo]
    {
        let context = CoreDataManager.context
        
        var annees : [AnneePromo] = []
        
        let request : NSFetchRequest<AnneePromo> = AnneePromo.fetchRequest()
        
        do
        {
            try annees = context.fetch(request)
        }
        catch let error as NSError{
            throw error
        }
        
        return annees
    }
}
    
