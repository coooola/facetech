//
//  DocumentViewController.swift
//  Facetech
//
//  Created by Julia Favrel on 23/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit
import CoreData

class DocumentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate
{

    @IBOutlet weak var documentTableView: UITableView!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.documentTableView.delegate = self

        do{
            DocumentSetModel.viewController = self
            try DocumentSetModel.documentSet.tousLesDocuments.performFetch()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self,error:error)
        }
        
        // Permet de ne faire apparaitre le bouton pour ajouter un document officiel uniquement si l'utilisateur est un secrétaire ou un responsable
        if (Session.utilisateurConnecte?.possederTypeUtilisateur?.libelleTypeUtilisateur == "Etudiant" || Session.utilisateurConnecte?.possederTypeUtilisateur?.libelleTypeUtilisateur == "Enseignant"){
            addButton?.isEnabled      = false
            addButton?.tintColor    = UIColor.clear
        }else{
            addButton?.isEnabled      = true
            addButton?.tintColor    = nil
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action handler -
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        
        let doc = DocumentSetModel.documentSet.getTousDoc().object(at: indexPath)
        
        let utilisateur = Session.utilisateurConnecte?.possederTypeUtilisateur?.libelleTypeUtilisateur
        
        if ( utilisateur == "Responsable" || utilisateur == "Secrétaire"){
            Document.deleteDocument(document: doc)
        }
    }
    
    
    //MARK: - TABLE VIEW -
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = DocumentSetModel.documentSet.getTousDoc().sections else {return 0}
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = DocumentSetModel.documentSet.getTousDoc().sections?[section] else {
            fatalError("unexpected section name")
        }
        return section.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        guard let section = DocumentSetModel.documentSet.getTousDoc().sections?[section] else {
            fatalError("unexpected section number")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.documentTableView.dequeueReusableCell(withIdentifier: "cellDocument", for: indexPath) as! DocumentTableViewCell
        
       let nom = DocumentSetModel.documentSet.getTousDoc().object(at: indexPath).nomDocument
        let url = DocumentSetModel.documentSet.getTousDoc().object(at: indexPath).urlDocument
        
            cell.nomDocumentLabel?.text = nom
            cell.urlDocumentLabel?.text = url
            cell.urlDocumentLabel?.linkTextAttributes = [ NSForegroundColorAttributeName: UIColor.blue ]
        return cell
    }
    
    // tell if a particular row can be edited
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Suppr", handler: self.deleteHandlerAction)
        delete.backgroundColor = UIColor.red
        return [delete]
    }
    
    
    //MARK: - Navigation
    
    @IBAction func unwindToDocumentListAfterAddingNewDocument(segue: UIStoryboardSegue)
    {
        let createViewController = segue.source as! CreateDocumentViewController
        do
        {
            _ = try DocumentSetModel.documentSet.insertDocument(nomdoc: createViewController.nomDoc, urldoc: createViewController.urlDoc);
        }
        catch let error as NSError
        {
            DialogBoxHelper.alert(view : self, error: error)
        }
        
        self.documentTableView.reloadData()
    }
    
    
    // MARK: - Controller -
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.documentTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.documentTableView.endUpdates()
        self.documentTableView.reloadData()
        self.viewDidLoad()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?)
    {
        switch type{
        case .insert:
            if let newIndexPath = newIndexPath{
                self.documentTableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath{
                self.documentTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type{
        case .insert:
            self.documentTableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            break
        }
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
