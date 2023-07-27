//
//  ViewController.swift
//  Desafio3.2
//
//  Created by Daniel Braga Barbosa on 06/03/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var todasAsPalavras = [String]()
    var caracteresUtilizados = [String]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(trocaPalavras))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reiniciaJogo))
        
        if let comecaPalavrasURL = Bundle.main.url(forResource: "palavras", withExtension: "txt")
        {
            if let comecaPalavras = try? String(contentsOf: comecaPalavrasURL)
            {
                todasAsPalavras = comecaPalavras.components(separatedBy: "\n")
            }
        }
        
        startJogo()
    }

    @objc func startJogo()
    {
        title = todasAsPalavras.randomElement()
        caracteresUtilizados.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    @objc func trocaPalavras()
    {
        
    }
    
    @objc func reiniciaJogo()
    {
        
    }
    
}

