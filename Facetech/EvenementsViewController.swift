//
//  EvenementsViewController.swift
//  Facetech
//
//  Created by Polytech on 19/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit
import CoreData


class EvenementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate
{
    
    @IBOutlet weak var evenementTableView: UITableView!
    
    
    /**
    
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
    
**/
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var nbEvent : Int = 0
        do{
            nbEvent = try EvenementsSetModel.evenementSet.getTousLesEvenements().count
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error:error)
        }
        
        return nbEvent
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
        let cell = self.evenementTableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EvenementTableViewCell
        do{
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "fr_FR") as Locale!
            dateFormatter.dateFormat = "HH:mm"
            
            if (try EvenementsSetModel.evenementSet.getTousLesEvenements()[indexPath.row].dateEvenement != nil)
            {
                cell.heureLabel.text = try dateFormatter.string(from: EvenementsSetModel.evenementSet.getTousLesEvenements()[indexPath.row].dateEvenement as! Date)
                cell.heureLabel.text = cell.heureLabel.text! + " : "
            }
            //try print(EvenementsSetModel.evenementSet.getTousLesEvenements()[indexPath.row].aLieuLe?.date?.description ?? "Ca ne marche pas :) :)")
            cell.nomEventLabel.text = try EvenementsSetModel.evenementSet.getTousLesEvenements()[indexPath.row].nomEvenement
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self, error:error)
        }
        
        return cell
     }

    

}
