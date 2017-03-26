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
    //MARK: - OUTLETS -
    
    @IBOutlet weak var evenementTableView: UITableView!
    
    //MARK: - UIViewController function -
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.evenementTableView.delegate = self
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
    
    
    // MARK: - Action handler -
    
   /* func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        
        let event = EvenementsSetModel.evenementSet.tousLesEvenements.object(at: indexPath)
        
        let utilisateur = Session.utilisateurConnecte?.possederTypeUtilisateur?.libelleTypeUtilisateur
        
        if ( utilisateur == "Responsable" || utilisateur == "Secrétaire"){
            Evenement.deleteEvenement(evenement: event)
        }
    }*/

    
    
    //MARK: - TABLE VIEW -
    
    /// Return the number of section of a tableView
    ///
    /// - Parameters:
    ///   - tableView: the table view
    /// - Returns: the number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = EvenementsSetModel.evenementSet.getTousEvent().sections else {return 0}
        return sections.count
    }
    
    /// Return the name of a section
    ///
    /// - Parameters:
    ///   - tableView: the table view
    ///   - section: the section
    /// - Returns: the name of the section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = EvenementsSetModel.evenementSet.getTousEvent().sections?[section] else {
            fatalError("unexpected section name")
        }
        return section.name
    }
    
    /// Return the number row in a section
    ///
    /// - Parameters:
    ///   - tableView: the table view
    ///   - section: teh section
    /// - Returns: number of row in the section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard let section = EvenementsSetModel.evenementSet.getTousEvent().sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.numberOfObjects
    }
    
    
    /// Define the cell of the tableview
    ///
    /// - Parameters:
    ///   - tableView: the table view
    ///   - indexPath: the index of each cell
    /// - Returns: the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
        let cell = self.evenementTableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EvenementTableViewCell
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale(localeIdentifier: "fr_FR") as Locale!
            dateFormatter.dateFormat = "HH:mm"
            
            if (EvenementsSetModel.evenementSet.getTousEvent().object(at: indexPath).dateEvenement != nil)
            {
                cell.heureLabel.text = dateFormatter.string(from: EvenementsSetModel.evenementSet.getTousEvent().object(at: indexPath).dateEvenement as! Date)
                cell.heureLabel.text = cell.heureLabel.text! + " : "
            }
           
            cell.nomEventLabel.text = EvenementsSetModel.evenementSet.getTousEvent().object(at: indexPath).nomEvenement
        
        
        return cell
     }
    
   /* // tell if a particular row can be edited
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Suppr", handler: self.deleteHandlerAction)
        delete.backgroundColor = UIColor.red
        return [delete]
    }*/

    
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
        self.evenementTableView.reloadData()
        self.viewDidLoad()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
    {
        switch type{
        case .insert:
            if let newIndexPath = newIndexPath{
                self.evenementTableView.insertRows(at: [newIndexPath], with: .fade)
            }
        /*case .delete:
            if let indexPath = indexPath{
                self.evenementTableView.deleteRows(at: [indexPath], with: .automatic)
            }*/

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
