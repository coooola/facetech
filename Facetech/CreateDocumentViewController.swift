//
//  CreateDocumentViewController.swift
//  Facetech
//
//  Created by Julia Favrel on 23/03/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit

class CreateDocumentViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var urlDocTextField: UITextField!
    @IBOutlet weak var nomDocTextField: UITextField!
    
    var nomDoc : String = ""
    var urlDoc : String = ""
    
    /*@IBAction func addDocButton(_ sender: Any) {
        
        let nom = self.nomDocTextField.text
        let url = self.urlDocTextField.text
        
        //Créé le message si le nom et l'url sont non vide
        if ((nom != nil) || (url != nil)){
            
            Document.createDocument(nomDocument: nom!, urlDocument: url!)
            
            self.nomDocTextField.text=nil
            self.urlDocTextField.text=nil
        }
        else{
            DialogBoxHelper.alertEmpty(view: self)
        }
        
    }*/
    
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - UITextFieldDelegate Functions
    
    /// <#Description#>
    ///
    /// - Parameter textField: <#textField description#>
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if  let nomDocc = self.nomDocTextField.text
        {
            self.nomDoc = nomDocc
        }
        if  let urlDocc = self.urlDocTextField.text
        {
            self.urlDoc = urlDocc
        }
    }

    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.nomDocTextField.backgroundColor = UIColor.white
    }
    
    /// <#Description#>
    ///
    /// - Parameter textField: <#textField description#>
    /// - Returns: <#return value description#>
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder();
        return true;
    }
    
    //MARK: - Actions
    
    @IBAction func cancelAction(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - identifier: <#identifier description#>
    ///   - sender: <#sender description#>
    /// - Returns: <#return value description#>
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool
    {
        self.textFieldDidEndEditing(nomDocTextField)
        
        if (self.nomDoc=="")
        {
            self.nomDocTextField.placeholder = "REMPLISSEZ CE CHAMP SVP"
            self.nomDocTextField.backgroundColor = UIColor.red
            return false
        }
        if (self.urlDoc=="")
        {
            self.urlDocTextField.placeholder = "REMPLISSEZ CE CHAMP SVP"
            self.urlDocTextField.backgroundColor = UIColor.red
            return false
        }
        
        
        return true
        
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
