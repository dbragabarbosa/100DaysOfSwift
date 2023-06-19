//
//  ViewController.swift
//  Project18
//
//  Created by Daniel Braga Barbosa on 19/06/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        print(1, 2, 3, 4, 5, separator: "-")
//        print("Some message", terminator: "")
//
//        assert (1 == 1, "Maths failure!")
//        assert (1 == 2, "Maths failure!")
        
        for i in 1 ... 100
        {
            print("Got number \(i)")
        }
    }


}

