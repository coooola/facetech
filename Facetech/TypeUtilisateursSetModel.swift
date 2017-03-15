//
//  TypeUtilisateursSetModel.swift
//  Facetech
//
//  Created by Nicolas BITAN on 15/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
import CoreData


class TypeUtilisateursSetModel: NSObject{
    
    
    static var typeUtilisateurSet = {
        return TypeUtilisateursSetModel()
    }()
    
    
    private var tousLesTypesUtilisateurs : [TypeUtilisateur] = []
    
    
    
    func getTousLesTypesUtilisateurs() throws -> [TypeUtilisateur]
    {
        if (tousLesTypesUtilisateurs.count == 0)
        {
            let context = CoreDataManager.context
            
            let request : NSFetchRequest<TypeUtilisateur> = TypeUtilisateur.fetchRequest()
            
            do
            {
                try tousLesTypesUtilisateurs = context.fetch(request)
            }
            catch let error as NSError{
                throw error
            }
        }
        
        return tousLesTypesUtilisateurs
    }
}
