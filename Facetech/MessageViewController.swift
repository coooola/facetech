//
//  MessageViewController.swift
//  Facetech
//
//  Created by Julia Favrel on 02/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit
import CoreData

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UITextFieldDelegate,UISearchResultsUpdating
    
{
    //MARK: - OUTLETS -
    
    @IBOutlet weak var messageTextField: UITextView!
    @IBOutlet weak var messageTable: UITableView!
    @IBOutlet var messagePresenter: MessagePresenter!
  
    //MARK: - VARIABLES -

    var filtredMessage = [Message]()
    var resultSeachController = UISearchController()
    
    //MARK: - UIViewController function -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            MesagesSetModel.viewController = self
            MesagesSetModel.messageSet = MesagesSetModel()
            
            try MesagesSetModel.messageSet.tousLesMessages.performFetch()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self,error:error)
        }
        
        // l'initialisation de SeachController avec un UISearchController vide
        self.resultSeachController = UISearchController(searchResultsController: nil)
        
        // Paramétrer le SeachController
        self.resultSeachController.searchResultsUpdater = self
        self.resultSeachController.dimsBackgroundDuringPresentation = false
        self.resultSeachController.searchBar.sizeToFit()
        
        // Ajout de SeachController au Header du tableView
        self.messageTable.tableHeaderView = self.resultSeachController.searchBar
        
        // Modifier le titre du notre SearchTableViewController
        self.title = "Messages"
        
        // Actualisation du tableView
        self.messageTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - Action handler -
    
    /// Call the delete function
    ///
    /// - Parameters:
    ///   - action: the action
    ///   - indexPath: the index of the message to delete
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        
        let message = MesagesSetModel.messageSet.tousLesMessages.object(at: indexPath)
        let mail = message.etreEcritPar?.adresseMail
        
        if (Session.utilisateurConnecte?.adresseMail == mail){
            Message.deleteMessage(message: message)
        }
    }
    
    
   
    // MARK: - Controller -
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.messageTable.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.messageTable.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
        case .delete:
            if let indexPath = indexPath{
                self.messageTable.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath{
                self.messageTable.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type{
        case .insert:
            self.messageTable.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            self.messageTable.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            break
        }
    }

    
    // MARK: - Table View data source protocol -
    
    /// Return the number row in a section
    ///
    /// - Parameters:
    ///   - tableView: the table view
    ///   - section: teh section
    /// - Returns: number of row in the section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if self.resultSeachController.isActive {
            return self.filtredMessage.count
        }
        else{
        guard let section = MesagesSetModel.messageSet.tousLesMessages.sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.numberOfObjects
        }
    }
    
    /// Return the number of sections
    ///
    /// - Parameters:
    ///   - tableView: the table view
    /// - Returns: number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = MesagesSetModel.messageSet.tousLesMessages.sections else {return 0}
        return sections.count
    }
    
    /// Return the name of a section
    ///
    /// - Parameters:
    ///   - tableView: the table view
    ///   - section: the section
    /// - Returns: the name of the section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = MesagesSetModel.messageSet.tousLesMessages.sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.name
    }
    
    /// Define the cell of the tableview
    ///
    /// - Parameters:
    ///   - tableView: the table view
    ///   - indexPath: the index of each cell
    /// - Returns: the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.messageTable.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        
        let message : Message
        if self.resultSeachController.isActive {
            message = self.filtredMessage[indexPath.row]
        }
        else{
            message = MesagesSetModel.messageSet.tousLesMessages.object(at: indexPath)
        }
        self.messagePresenter.configure(theCell: cell, forMessage: message)
        return cell
    }
    
    
    /// Tell if a tableview can be edited
    ///
    /// - Parameters:
    ///   - tableView: tableview related
    ///   - indexPath: index for the table
    /// - Returns: YES the table can be edited or NO
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /// Give different options for a selected row
    ///
    /// - Parameters:
    ///   - tableView: the tablevView
    ///   - indexPath: the index path of the cell
    /// - Returns: the type of action
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Suppr", handler: self.deleteHandlerAction)
        delete.backgroundColor = UIColor.red
        return [delete]
    }
    
    //MARK: - Search control
    
    func updateSearchResults(for searchController:  UISearchController)
    {
        // Supprimer tous les éléments du filtredTeams
        self.filtredMessage.removeAll(keepingCapacity: false)

        // Créer un NSArray (ce array représente SELF dans le Predicate créé)
        let array = MesagesSetModel.messageSet.tousLesMessages.fetchedObjects?.filter({
            return (($0 as Message).contenu?.contains(searchController.searchBar.text!))!
        })
        
        // Nouveau filtredTeams de la requête du Predicate
        if (array != nil)
        {
            self.filtredMessage = array!
        }
        // Actualisation du tableView
        self.messageTable.reloadData()
    }
    

    
    ///MARK: - Navigation
    
    @IBAction func unwindToMessageListAfterAddingNewMessage(segue: UIStoryboardSegue)
    {
        let createViewController = segue.source as! CreateMessageViewController
        
        //Créé le message si l'utilisateur est connecté et le message non vide
        if (Session.utilisateurConnecte != nil){
            
            //Recupere les utilisateurs destinataires du message dans la variable
            let typesUsers : [TypeUtilisateur] = createViewController.getTypesUtilisateurMsg()
            
            let annees : [AnneePromo] = createViewController.getAnneePromo()
            
            Message.createMessage(etreEcritPar: Session.utilisateurConnecte!, contenu: createViewController.msgText.text, typesUtilisateurs : typesUsers, anneesPromo : annees)
            
        }
        else{
            DialogBoxHelper.alertEmpty(view: self)
        }
        
        self.messageTable.reloadData()
    }
    
    

}
