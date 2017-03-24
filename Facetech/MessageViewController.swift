//
//  MessageViewController.swift
//  Facetech
//
//  Created by Julia Favrel on 02/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit
import CoreData

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var messageTextField: UITextView!
    @IBOutlet weak var messageTable: UITableView!
    @IBOutlet var messagePresenter: MessagePresenter!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            MesagesSetModel.viewController = self
            try MesagesSetModel.messageSet.tousLesMessages.performFetch()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self,error:error)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // MARK: - Action handler -
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        let message = MesagesSetModel.messageSet.tousLesMessages.object(at: indexPath)
        Message.deleteMessage(message: message)
    }
    
    func editHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        print("edit")
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
        //case .update:
            //self.messageTable.reloadData()
        default:
            break
        }
    }
    
    
    // MARK: - Table View data source protocol -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard let section = MesagesSetModel.messageSet.tousLesMessages.sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.numberOfObjects
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = MesagesSetModel.messageSet.tousLesMessages.sections else {return 0}
        return sections.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = MesagesSetModel.messageSet.tousLesMessages.sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.name
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.messageTable.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        let message = MesagesSetModel.messageSet.tousLesMessages.object(at: indexPath)
        self.messagePresenter.configure(theCell: cell, forMessage: message)
        cell.accessoryType = .detailButton
        return cell
    }
    
    
    // tell if a particular row can be edited
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Suppr", handler: self.deleteHandlerAction)
        let edit = UITableViewRowAction(style: .default, title: "Modifier", handler: editHandlerAction)
        delete.backgroundColor = UIColor.red
        edit.backgroundColor = UIColor.blue
        return [delete, edit]
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
