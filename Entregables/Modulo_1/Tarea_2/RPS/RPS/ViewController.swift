//
//  ViewController.swift
//  RPS
//
//  Created by Álvaro Ávalos Hernández on 11/08/18.
//  Copyright © 2018 Álvaro Ávalos Hernández. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var machineLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resetGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetGame() {
        machineLabel.text = "🤖"
        statusLabel.text = "Rock, Paper, Scissors?"
        rockButton.isHidden = false
        rockButton.isEnabled = true
        paperButton.isHidden = false
        paperButton.isEnabled = true
        scissorsButton.isHidden = false
        scissorsButton.isEnabled = true
        playAgainButton.isHidden = true
    }
    
    func play(_ playerTurn: Sign) {
        rockButton.isEnabled = false
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false
        
        let opponet = randomSign()
        machineLabel.text = opponet.emoji
        let resultGame = playerTurn.hand(opponet)
        switch resultGame {
        case .draw:
            statusLabel.text = "Buuu, draw!"
        case .lose:
            statusLabel.text = "Tsss, you lose!"
        case .win:
            statusLabel.text = "Good, you win!"
        case .start:
            statusLabel.text = "Rock, Paper, Scissors?"
        }
        
        switch playerTurn {
        case .rock:
            rockButton.isHidden = false
            paperButton.isHidden = true
            scissorsButton.isHidden = true
        case .paper:
            rockButton.isHidden = true
            paperButton.isHidden = false
            scissorsButton.isHidden = true
        case .scissors:
            rockButton.isHidden = true
            paperButton.isHidden = true
            scissorsButton.isHidden = false
        }
        playAgainButton.isHidden = false
    }

    @IBAction func playAgainSelected(_ sender: Any) {
        resetGame()
    }
    
    @IBAction func rockSelected(_ sender: Any) {
        play(Sign.rock)
    }
    
    @IBAction func paperSelected(_ sender: Any) {
        play(Sign.paper)
    }
    
    @IBAction func scissorsSelected(_ sender: Any) {
        play(Sign.scissors)
    }
}

