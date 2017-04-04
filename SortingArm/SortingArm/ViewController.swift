//
//  ViewController.swift
//  SortingArm
//
//  Created by Jeremy Swafford on 3/30/17.
//  Copyright © 2017 NCSU ECE Project 14. All rights reserved.
//

import UIKit

import VisualRecognitionV3

let apiKey = "8184c961e86deb450925a2196ddfde4dbb1f1721"
let version = "2017-04-04" // use today's date for the most recent version
let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doit(_ sender: UIButton) {
        test()
    }
    
    func test(){
        
        let url = "http://res.freestockphotos.biz/pictures/10/10240-an-empty-brown-beer-bottle-isolated-on-a-white-background-pv.jpg"
        let failure = { (error: Error) in print(error) }
        visualRecognition.classify(image: url, failure: failure) { classifiedImages in
            print(classifiedImages)
        }
    }
}

