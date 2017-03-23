//
//  DocumentExtension.swift
//  Facetech
//
//  Created by Julia Favrel on 23/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
import CoreData

extension Document{
    
    
    static func createDocument(nomDocument: String, urlDocument: String, dateCreationDocument: Date) -> Document
    {
        let newDoc = Document(context : CoreDataManager.context)
        newDoc.nomDocument = nomDocument
        newDoc.urlDocument = urlDocument
        newDoc.dateCreationDocument = dateCreationDocument as NSDate
        
        return newDoc
        
    }
    
    var time: String {
        get {
            if (self.dateCreationDocument != nil)
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm:ss"
                let convertedDate = dateFormatter.string(from: self.dateCreationDocument as! Date)
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
            if (self.dateCreationDocument != nil)
            {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                let convertedDate = dateFormatter.string(from: self.dateCreationDocument as! Date)
                return convertedDate
            }
            else
            {
                return "Date Inconnue"
            }
        }
    }
    
    
    
    
}

