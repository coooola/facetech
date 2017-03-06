//
//  MessageViewController.swift
//  Facetech
//
//  Created by Julia Favrel on 02/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit
import CoreData

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var messages : [Message] = []
    
    @IBOutlet weak var messageTable: UITableView!
    
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
    
    func alertError(errorMsg error : String, msgInfo msg: String = ""){
        let alert = UIAlertController(title: error,
                                      message: msg,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok",
                                         style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // first get context of persistent data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            self.alertError(errorMsg: "Could not load data", msgInfo: "reason unknown")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        // create request associate to entity Message
        let request : NSFetchRequest<Message> = Message.fetchRequest()
        do{
            try self.messages = context.fetch(request)
        }
        catch let error as NSError{
            self.alertError(errorMsg: "\(error)", msgInfo: "\(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.messageTable.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        cell.contentLabel.text = self.messages[indexPath.row].contenu
        return cell
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
