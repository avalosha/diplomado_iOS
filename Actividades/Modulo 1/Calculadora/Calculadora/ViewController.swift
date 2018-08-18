//
//  ViewController.swift
//  Calculadora
//
//  Created by Álvaro Ávalos Hernández on 18/08/18.
//  Copyright © 2018 Álvaro Ávalos Hernández. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var showResult: UILabel!
    var cadena = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func enterNumbers(_ sender: UIButton) {
        cadena += sender.currentTitle!
        showResult.text = cadena
    }
    
    @IBAction func cleanScreen(_ sender: UIButton) {
        cadena = "0"
        showResult.text = cadena
    }
    
}

