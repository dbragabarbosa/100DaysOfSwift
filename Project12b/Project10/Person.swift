//
//  Person.swift
//  Project10
//
//  Created by Daniel Braga Barbosa on 06/09/22.
//

import UIKit

class Person: NSObject
{
    var name: String
    var image: String
    
    init(name: String, image: String)
    {
        self.name = name
        self.image = image 
    }
}
