//
//  ViewController.swift
//  Facetech
//
//  Created by Nicolas BITAN on 13/02/2017.
//  Copyright © 2017 Nicolas BITAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    //MARK: Properties
    

    @IBOutlet weak var identifiantTextField: UITextField!
    
    @IBOutlet weak var mdpTextField: UITextField!
    
    var id : String = "";
    var mdp : String = "";
    
    
    //MARK: UIViewController methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        identifiantTextField.delegate = self
        mdpTextField.delegate = self
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        identifiantTextField.resignFirstResponder();
        mdpTextField.resignFirstResponder();
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if  let saisieId = self.identifiantTextField.text
        {
            self.id = saisieId;
        }
        else
        {
            self.id = "Ecris quelque chose !";
        }
        if  let saisieMdp = self.mdpTextField.text
        {
            self.mdp = saisieMdp;
        }
        else
        {
            self.mdp = "Ecris quelque chose !";
        }
    }

    
    
    //MARK: Functions
    
    @IBAction func seConnecterButton(_ sender: Any)
    {
        if self.id == "Nicolas" && self.mdp == "123456"
        {
        }
    }

}

