//
//  ViewController.swift
//  ISpy
//
//  Created by Álvaro Ávalos Hernández on 25/08/18.
//  Copyright © 2018 Álvaro Ávalos Hernández. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollViewMain: UIScrollView!
    @IBOutlet weak var imageViewMain: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollViewMain.delegate = self
        updateZoomFor(size: view.bounds.size)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageViewMain
    }
    
    func updateZoomFor(size: CGSize) {
        let widthScale = size.width / imageViewMain.bounds.width
        let heightScale = size.height / imageViewMain.bounds.height
        let scale = min(widthScale, heightScale)
        scrollViewMain.minimumZoomScale = scale
    }
}

