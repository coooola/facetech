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
    
    var time: String {
        get {
            if (self.dateEvenement != nil)
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss"
                let convertedDate = dateFormatter.string(from: self.dateEvenement as! Date)
                return convertedDate
            }
            else
            {
                return "00:00:00"
            }
        }
    }
    
    var date: String {
        get {
            if (self.dateEvenement != nil)
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let convertedDate = dateFormatter.string(from: self.dateEvenement as! Date)
                return convertedDate
            }
            else
            {
                return "Date Inconnue"
            }
        }
    }
    
    
    
    
}
