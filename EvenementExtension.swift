//
//  EvenementExtension.swift
//  Facetech
//
//  Created by Polytech on 19/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
import CoreData

extension Evenement{
    
    
    static func createEvenement(nom: String, date: Date) -> Evenement
    {
        let newEvent = Evenement(context : CoreDataManager.context)
        newEvent.nomEvenement = nom
        newEvent.dateEvenement = date as NSDate
        
        return newEvent
        
    }
    
    
    
    
}
