//
//  FillPlayerNameViewController.swift
//  HW9-4_Scoreboard
//
//  Created by Dawei Hao on 2023/4/28.
//

import UIKit

class FillPlayerNameViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var player1NameLabel: UILabel!
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var player1TextField: UITextField!
    @IBOutlet weak var player2TextField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Player1 Name
        player1NameLabel.text = "Player1 Name"
        player1NameLabel.frame = CGRect(x: 80, y: 300, width: 104, height: 21)
        
        //Player2 Name
        player2NameLabel.text = "Player2 Name"
        player2NameLabel.frame = CGRect(x: 80, y: 405, width: 106, height: 21)
        
        //Player1 text field
        player1TextField.placeholder = "Please enter the player 1 name"
        player1TextField.frame = CGRect(x: 80, y: 343, width: 232, height: 34)
        
        //Player2 text field
        player2TextField.placeholder = "Please enter the player 2 name"
        player2TextField.frame = CGRect(x: 80, y: 445, width: 232, height: 34)
        
        //Go button
        goButton.layer.cornerRadius = 20
        goButton.frame = CGRect(x: 118, y: 517, width: 157, height: 40)
    }
    
    @IBAction func goButtonTapped(_ sender: Any) {
        if player1TextField.text! == "" && player2TextField.text! == "" {
            alertForWithOutClickKeyIn()
        } else {
            performSegue(withIdentifier: "segue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scoreboardViewController = segue.destination as! ScroeboardViewController
        scoreboardViewController.text = player1TextField.text!
        scoreboardViewController.text1 = player2TextField.text!
    }
    
    func alertForWithOutClickKeyIn() {
        let withoutKeyInController = UIAlertController(title: "是不是忘了什麼?", message: "提醒您記得輸入玩家名稱", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        withoutKeyInController.addAction(okAction)
        self.present(withoutKeyInController, animated: true)
    }
}
