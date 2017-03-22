//
//  Session.swift
//  Facetech
//
//  Created by Nicolas BITAN on 15/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
class Session : NSObject{
    
    
    /// Instance et instanciation du singleton afin d'assurer l'unicité de la variable privée suivante
    static var session = {
        return Session()
    }()
    
    /// Override de l'init pour éviter les instanciations externes.
    private override init() {}
    
    /// Variable privée contenant l'utilisateur connecté (ou pas)
    static private var putilisateurConnecte : Utilisateur? = nil
    
    
    /// Variable gérant l'utilisateur connecté
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
    
    
    /// Déconnexion de l'utilisateur : s'assure qu'il n'y a plus d'utilisateur existant.
    func disconnectUser()
    {
        Session.putilisateurConnecte = nil;
    }
    
    
    
    
    
    
}
