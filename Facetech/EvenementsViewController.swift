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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        do{
            EvenementsSetModel.viewController = self
            try EvenementsSetModel.evenementSet.tousLesEvenements.performFetch()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self,error:error)
        }
    }
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - TABLE VIEW -
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = EvenementsSetModel.evenementSet.tousLesEvenements.sections else {return 0}
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = EvenementsSetModel.evenementSet.tousLesEvenements.sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard let section = EvenementsSetModel.evenementSet.tousLesEvenements.sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.numberOfObjects
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
        let cell = self.evenementTableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EvenementTableViewCell
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "fr_FR") as Locale!
            dateFormatter.dateFormat = "HH:mm"
            
            if (EvenementsSetModel.evenementSet.tousLesEvenements.object(at: indexPath).dateEvenement != nil)
            {
                cell.heureLabel.text = dateFormatter.string(from: EvenementsSetModel.evenementSet.tousLesEvenements.object(at: indexPath).dateEvenement as! Date)
                cell.heureLabel.text = cell.heureLabel.text! + " : "
            }
           
            cell.nomEventLabel.text = EvenementsSetModel.evenementSet.tousLesEvenements.object(at: indexPath).nomEvenement
        
        
        return cell
     }

    
    //MARK: - Navigation
    
    @IBAction func unwindToEventListAfterAddingNewEvent(segue: UIStoryboardSegue)
    {
        let createViewController = segue.source as! CreateEvenementViewController
        do
        {
            _ = try EvenementsSetModel.evenementSet.insertEvenement(nom: createViewController.nomEvenement, date: createViewController.dateEvenementDatePicker.date);
        }
        catch let error as NSError
        {
            DialogBoxHelper.alert(view : self, error: error)
        }
        
        self.evenementTableView.reloadData()
    }
    
    
    // MARK: - Controller -
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.evenementTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.evenementTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
    {
        switch type{
        case .insert:
            if let newIndexPath = newIndexPath{
                self.evenementTableView.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type{
        case .insert:
            self.evenementTableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            break
        }
    }
    
    
}
