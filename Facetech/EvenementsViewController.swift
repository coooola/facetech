//
//  EvenementsViewController.swift
//  Facetech
//
//  Created by Polytech on 19/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit
import CoreData


class EvenementsViewController: UIViewController//, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate
{
    
    /**@IBOutlet weak var evenementsTableView: UITableView!
    
    @IBOutlet weak var evenementTableCell: UITableViewCell!
    
    fileprivate lazy var evenementsFetched : NSFetchedResultsController<Evenement> = {
        
        // prepare a request
        let request : NSFetchRequest<Evenement> = Evenement.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Message.etrePosteLe.date), ascending: true)]
        
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: #keyPath(Message.etrePosteLe), cacheName: nil)
        
        fetchResultController.delegate = self
        
        return fetchResultController //EvenementsSetModel.evenementSet.getTousLesElements()
    }()
    **/
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /**do{
            try self.evenementsFetched.performFetch()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self,error:error)
        }**/
    }
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {

    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
        default:
            break
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //return self.messages.count
        guard let section = self.evenementsFetched.sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.numberOfObjects
    }
    
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.evenementsTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! EvenementTableViewCell
        let message = self.evenementsFetched.object(at: indexPath)
        self.messagePresenter.configure(theCell: cell, forMessage: message)
        cell.accessoryType = .detailButton
        /*cell.textLabel?.numberOfLines=0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping*/
        return cell
    }
**/
    

}
