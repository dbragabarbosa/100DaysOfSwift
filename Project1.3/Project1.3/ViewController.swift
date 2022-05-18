//
//  ViewController.swift
//  Project1.3
//
//  Created by Daniel Braga Barbosa on 17/05/22.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        // Do any additional setup after loading the view.
        print(pictures)
    }


}

