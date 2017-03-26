//
//  UtilisateursSetModel.swift
//  Facetech
//
//  Created by Nicolas BITAN on 08/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import Foundation
import CoreData

class UtilisateursSetModel : NSObject{

    
    ///  Instance et instanciation du singleton afin d'assurer l'unicité de la variable privée suivante
    static var utilisateursSet = {
        return UtilisateursSetModel()
    }()
    
    ///  Override de l'init pour éviter les instanciations externes.
    private override init() {}
    
    
    static private var pViewController : NSFetchedResultsControllerDelegate? = nil
    
    
    static var viewController : NSFetchedResultsControllerDelegate? {
        get{
            return self.pViewController
        }
        set{
            if self.pViewController == nil{
                self.pViewController = newValue
            }
        }
    }
    
    
    /// - Description:
    /// Permet de créer un utilisateur
    /// - Parameters:
    ///   - mail: mail de l'utilisateur
    ///   - nom: nom de l'utilisateur
    ///   - prenom: prénom de l'utilisateur
    /// - Returns: l'utilisateur créé
    /// - Throws: retourne une erreur en cas d'erreur au moment de la sauvegard de l'objet créé
    func insertUtilisateur(mail: String, nom: String, prenom: String, annee: AnneePromo?, typeUtilisateur: TypeUtilisateur) throws -> Utilisateur
    {
        let newUser = Utilisateur.createUtilisateur(mail: mail, nom: nom, prenom: prenom, annee: annee, typeUtilisateur: typeUtilisateur)

        if let error = CoreDataManager.save()
        {
            throw error
        }
    
        return newUser        
    }
    
    
    /// Variable privée contenant tous les documents.
    lazy var tousLesUtilisateurs: NSFetchedResultsController<Utilisateur> =
        {
            let request : NSFetchRequest<Utilisateur> = Utilisateur.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Utilisateur.nom), ascending: false)]
            let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: #keyPath(Utilisateur.possederTypeUtilisateur.libelleTypeUtilisateur), cacheName: nil)
            
            fetchResultController.delegate = viewController
            
            return fetchResultController
    }()
    
    func getTousUtilisateurs() -> NSFetchedResultsController<Utilisateur> {
        return tousLesUtilisateurs
    }

    
    
    /// Récupère un utilisateur grâce à son mail d'authentification
    ///
    /// - Parameter mail: mail exact de l'utilisateur
    /// - Returns: l'utilisateur correspondant au mail en paramètre
    /// - Throws: exception en cas d'erreur lors de la requête
    func getUtilisateurByMail(mail: String? = nil) throws -> Utilisateur?
    {
        
        let context = CoreDataManager.context
        
        var user : [Utilisateur] = []
        
        let request : NSFetchRequest<Utilisateur> = Utilisateur.fetchRequest()

        request.predicate = NSPredicate(format: "adresseMail == %@", mail != nil ? mail! : "")
        
        do
        {
            try user = context.fetch(request)
        }
        catch let error as NSError{
            throw error
        }
        
        return user.count != 0 ? user[0]: nil
        
    }
    
    
    /// Retourne le nombre d'utilisateur dans la base.
    ///
    /// - Returns: le nombre d'utilisateur dans la base
    /// - Throws: exception en cas d'erreur lors de la requête
    func countAllUserInBase() throws -> Int
    {
        
        let context = CoreDataManager.context
        
        var user : [Utilisateur] = []
        
        let request : NSFetchRequest<Utilisateur> = Utilisateur.fetchRequest()
        
        
        do
        {
            try user = context.fetch(request)
        }
        catch let error as NSError{
            throw error
        }
        
        return user.count
        
    }
    
    func createAdmin()
    {
        do
        {
            _ = try TypeUtilisateursSetModel.typeUtilisateurSet.getTousLesTypesUtilisateurs()
            _ = try insertUtilisateur(mail: "admin@facetech.fr", nom: "Istrateur", prenom: "Admin", annee: nil, typeUtilisateur: (TypeUtilisateursSetModel.typeUtilisateurSet.getTypeUtilisateur(name: "Secrétaire"))!)
        }
        catch _ as NSError
        {
            
        }
        
    }
    
    
    /// - Description
    /// Récupère un utilisateur grâce à son id
    ///
    /// - Parameter id: id exact de l'utilisateur
    /// - Returns: L'utilisateur correspondant à l'id en paramètre
    /// - Throws: exception en cas d'erreur lros de la requête
    func getUtilisateurById(id: Int) throws -> Utilisateur?
    {
        
        let context = CoreDataManager.context
        
        var user : Utilisateur? = nil
        
        let request : NSFetchRequest<Utilisateur> = Utilisateur.fetchRequest()
        
        request.predicate = NSPredicate(format: "idUtilisateur == %@", id)
        
        do
        {
            try user = context.fetch(request).first
        }
        catch let error as NSError{
            throw error
        }
        
        return user
    }
    
    
    func updateUtilisateur(user: Utilisateur) throws -> Utilisateur?
    {
        if let error = CoreDataManager.save()
        {
            throw error
        }
        
        return user
    }
    
    
    
}
