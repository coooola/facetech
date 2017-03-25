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
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        nomDocTextField.delegate = self
        urlDocTextField.delegate = self
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
        //if  let nomDocc = self.nomDocTextField.text
        //{
            self.nomDoc = self.nomDocTextField.text ?? ""
        //}
        //if  let urlDocc = self.urlDocTextField.text
        //{
            self.urlDoc = self.urlDocTextField.text ?? ""
       // }
    }

    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.nomDocTextField.backgroundColor = UIColor.white
        self.urlDocTextField.backgroundColor = UIColor.white
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
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
     
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - identifier: <#identifier description#>
    ///   - sender: <#sender description#>
    /// - Returns: <#return value description#>
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool
    {
        self.textFieldDidEndEditing(nomDocTextField)
        self.textFieldDidEndEditing(urlDocTextField)

        
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
