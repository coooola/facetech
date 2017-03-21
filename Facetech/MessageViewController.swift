//
//  MessageViewController.swift
//  Facetech
//
//  Created by Julia Favrel on 02/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit
import CoreData

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate{
    
    var messages : [Message] = []
    
    fileprivate lazy var messagesFetched : NSFetchedResultsController<Message> = {
        
        // prepare a request
        let request : NSFetchRequest<Message> = Message.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Message.etrePosteLe.date), ascending: true)]
        
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: #keyPath(Message.etrePosteLe), cacheName: nil)
        
        fetchResultController.delegate = self
        
        return fetchResultController
    }()
    
    
    
    @IBOutlet weak var messageTable: UITableView!
    @IBOutlet var messagePresenter: MessagePresenter!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        do{
            try self.messagesFetched.performFetch()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self,error:error)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    /// Called when `add button`is pressed
    ///
    /// Dislpay a dialog box to allow user to enter a name. If a name is entered then create a new `Message`, add it to the table and save data
    /// - Parameter sender: object that trigger action
    @IBAction func addAction(_ sender: Any) {
        let alert = UIAlertController(title: "Nouveau Message",
                                  message: "Ajouter un message",
                                  preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Ajouter",
                                       style: .default)
        {
                [unowned self] action in
                guard let textField = alert.textFields?.first,
                let messageToSave = textField.text else{
                    return
            }
            self.saveNewMessage(withContent: messageToSave)
            self.messageTable.reloadData()
        }
        
        let cancelACtion = UIAlertAction(title: "Annuler",
                                         style: .default)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelACtion)
        
        present(alert, animated: true)
    }
    
    // MARK: - Action handler -
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        let message = self.messagesFetched.object(at: indexPath)
        CoreDataManager.context.delete(message)
    }
    
    func editHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        print("edit")
    }
    
    
   
    // MARK: - Messsage data management -

    /// Enregistre un nouveau message
    ///
    /// - Parameter contenuMsg: le contenu du message a ajouter dans la base de données
    func saveNewMessage(withContent contenuMsg: String){
        
        // first get context into application delegate
        let context = CoreDataManager.context
        
        // create a messageManagedObject
        let message = Message(context: context)
        
        // then modify its content
        message.contenu = contenuMsg
        
        do{
            try CoreDataManager.save()
            self.messages.append(message)
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error: error)
            return
        }
    }

    
    // MARK: - NSFetchResultController delegate protocol
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.messageTable.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.messageTable.endUpdates()
        CoreDataManager.save()
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
    
    
    // MARK: - Table View data source protocol -
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //return self.messages.count
        guard let section = self.messagesFetched.sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.numberOfObjects
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.messageTable.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        let message = self.messagesFetched.object(at: indexPath)
        self.messagePresenter.configure(theCell: cell, forMessage: message)
        cell.accessoryType = .detailButton
        /*cell.textLabel?.numberOfLines=0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping*/
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
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    

}
