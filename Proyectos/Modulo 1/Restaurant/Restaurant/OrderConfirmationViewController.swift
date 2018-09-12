//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Álvaro Ávalos Hernández on 09/09/18.
//  Copyright © 2018 Álvaro Ávalos Hernández. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    var minutes: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!) minutes."
    }

}
