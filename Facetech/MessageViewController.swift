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
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
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
    
    
    // Mark: - Message data management -
    
    /// save all data
    ///
    
    func save(){
        // first get context into application delegate
        if let error = CoreDataManager.save(){
            DialogBoxHelper.alert(view: self, error: error)
        }
    }

    // MARK: - Messsage data management -

    /// create a new message, add it to the collection and save it
    ///
    /// - Parameter contenuMsg: content of the Message to be add
    func saveNewMessage(withContent contenuMsg: String){
        // first get context into application delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            self.alertError(errorMsg: "Could not save message", msgInfo: "unknown reason")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        // create a message managedObject
        let message = Message(context: context)
        // then modify its content
        message.contenu = contenuMsg
        do{
            try context.save()
            self.messages.append(message)
        }
        catch let error as NSError{
            self.alertError(errorMsg: "\(error)", msgInfo: "\(error.userInfo)")
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
    
    
    // MARK: - helper methods
    /// Get context of core data initialized in application delegate
    ///
    /// - Parameters:
    ///   - errorMsg: main error message
    ///   - userInfoMsg: additional information in application delegate
    /// - Returns: context of coreData
    func getContext(errorMsg: String, userInfoMsg: String = "could not retrieve data context") -> NSManagedObjectContext?{
        // first get context of persistent data
        guard let  appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            DialogBoxHelper.alert(view: self, WithTitle: errorMsg, andMessage: userInfoMsg)
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    func alertError(errorMsg error : String, msgInfo msg: String = ""){
        let alert = UIAlertController(title: error,
                                      message: msg,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok",
                                         style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
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
