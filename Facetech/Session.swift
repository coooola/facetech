//
//  Session.swift
//  Facetech
//
//  Created by Nicolas BITAN on 15/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
class Session : NSObject{
    
    private override init() {}
    
    static var session = {
        return Session()
    }()
    
    
    static private var putilisateurConnecte : Utilisateur? = nil
    
    static var utilisateurConnecte : Utilisateur? {
        get{
            return self.putilisateurConnecte
        }
        set{
            if self.putilisateurConnecte == nil{
                self.putilisateurConnecte = newValue
            }
        }
    }
    
    class func disconnectUser()
    {
        putilisateurConnecte = nil;
    }
    
    
    
    
    
    
}
