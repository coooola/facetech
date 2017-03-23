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
    
    
    /// Instance et instanciation du singleton afin d'assurer l'unicité de la variable privée suivante
    static var typeUtilisateurSet = {
        return TypeUtilisateursSetModel()
    }()
    
    
    /// Override de l'init pour éviter les instanciations externes.
    private override init() {}
    
    
    /// Variable privée contenant tous les types d'utilisateurs.
    private var tousLesTypesUtilisateurs : [TypeUtilisateur] = []
    
    
    
    /// Récupère tous les types d'utilisateurs.
    ///
    /// - Returns: Tableau de l'ensemble des types d'utilisateur
    /// - Throws: une exception en cas d'erreur lors de l'éxécution de la requête
    func getTousLesTypesUtilisateurs() throws -> [TypeUtilisateur]
    {
        if (tousLesTypesUtilisateurs.count == 0)
        {
            let context = CoreDataManager.context
            
            let request : NSFetchRequest<TypeUtilisateur> = TypeUtilisateur.fetchRequest()
            
            do
            {
                try tousLesTypesUtilisateurs = context.fetch(request)
                
                //Dans le cas où l'application n'a pas encore été lancée
                if (tousLesTypesUtilisateurs.count == 0)
                {
                    let us1 : TypeUtilisateur = TypeUtilisateur(context : CoreDataManager.context)
                    us1.idTypeUtilisateur = 1
                    us1.libelleTypeUtilisateur = "Etudiant"
                
                    let us2 : TypeUtilisateur = TypeUtilisateur(context : CoreDataManager.context)
                    us2.idTypeUtilisateur = 2
                    us2.libelleTypeUtilisateur = "Enseignant"
                
                    let us3 : TypeUtilisateur = TypeUtilisateur(context : CoreDataManager.context)
                    us3.idTypeUtilisateur = 3
                    us3.libelleTypeUtilisateur = "Resposable du département"
                
                    let us4 : TypeUtilisateur = TypeUtilisateur(context : CoreDataManager.context)
                    us4.idTypeUtilisateur = 4
                    us4.libelleTypeUtilisateur = "Secrétaire"
                
                    CoreDataManager.save()
                    
                    try tousLesTypesUtilisateurs = context.fetch(request)
                }
                
                
                
            }
            catch let error as NSError{
                throw error
            }
        }
        
        return tousLesTypesUtilisateurs
    }
    
    func getTypeUtilisateur(name: String) throws -> TypeUtilisateur? {
        
        /*var typesUtilisateurs : [TypeUtilisateur]
         let request : NSFetchRequest<TypeUtilisateur> = TypeUtilisateur.fetchRequest()
         request.predicate = NSPredicate(format: "nomTypeUtilisateur", name)
         do{
         typesUtilisateurs = try CoreDataManager.context.fetch(request)
         return typesUtilisateurs[0]
         }
         catch let error as NSError{
         throw error
         }*/
        
        let typeUser : TypeUtilisateur = TypeUtilisateur(context : CoreDataManager.context)
        
        
        if (name == "Etudiant") {
            typeUser.idTypeUtilisateur = 1
            typeUser.libelleTypeUtilisateur = "Etudiant"
        }
        if (name == "Enseignant") {
            typeUser.idTypeUtilisateur = 2
            typeUser.libelleTypeUtilisateur = "Enseignant"
        }
        if (name == "Resposable du département") {
            typeUser.idTypeUtilisateur = 3
            typeUser.libelleTypeUtilisateur = "Resposable du département"
        }
        if (name == "Secrétaire") {
            typeUser.idTypeUtilisateur = 4
            typeUser.libelleTypeUtilisateur = "Secrétaire"
        }
        return typeUser
    }
}
