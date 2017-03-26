//
//  ListeUserViewController.swift
//  Facetech
//
//  Created by Julia Favrel on 26/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit

class ListeUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - OUTLETS -
    
    @IBOutlet weak var listeUserTableView: UITableView!
    
    //MARK: - UIViewController function -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listeUserTableView.delegate = self
        do{
            try UtilisateursSetModel.utilisateursSet.getTousUtilisateurs().performFetch()
        }
        catch let error as NSError{
            DialogBoxHelper.alert(view: self,error:error)
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action handler -
    
    /*func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void{
        
        let user = UtilisateursSetModel.utilisateursSet.getTousUtilisateurs().object(at: indexPath)
        
        Utilisateur.deleteUtilisateur(utilisateur: user)
        
    }*/
    
    //MARK: - TABLE VIEW -
    
    /// Return the number of section of a tableView
    ///
    /// - Parameters:
    ///   - tableView: the table view
    /// - Returns: the number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = UtilisateursSetModel.utilisateursSet.getTousUtilisateurs().sections else {return 0}
        return sections.count
    }
    
    /// Return the name of a section
    ///
    /// - Parameters:
    ///   - tableView: the table view
    ///   - section: the section
    /// - Returns: the name of the section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = UtilisateursSetModel.utilisateursSet.getTousUtilisateurs().sections?[section] else {
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
        guard let section = UtilisateursSetModel.utilisateursSet.getTousUtilisateurs().sections?[section] else {
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
        let cell = self.listeUserTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! ListeUserTableViewCell
        let nom = UtilisateursSetModel.utilisateursSet.getTousUtilisateurs().object(at: indexPath).nom
        let prenom = UtilisateursSetModel.utilisateursSet.getTousUtilisateurs().object(at: indexPath).prenom
        
        cell.nomLabel.text = nom
        cell.prenomLabel.text = prenom
        
        
        return cell
    }
    
     /*// tell if a particular row can be edited
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     return true
     }
     
     func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
     let delete = UITableViewRowAction(style: .default, title: "Suppr", handler: self.deleteHandlerAction)
     delete.backgroundColor = UIColor.red
     return [delete]
     }
    */



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
