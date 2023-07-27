//
//  ViewController.swift
//  Desafio2.2
//
//  Created by Daniel Braga Barbosa on 10/02/23.
//

import UIKit

class ViewController: UITableViewController
{
    
    var listaDePalavras = [String]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(caixaDeAdicao))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(limpaLista))
        
        play()
    }
    
    func play()
    {
        title = "Lista de compras"
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return listaDePalavras.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = listaDePalavras[indexPath.row]
        return cell
    }
    
    @objc func caixaDeAdicao()
    {
        let alerta = UIAlertController(title: "Digite o produto desejado:", message: nil, preferredStyle: .alert)
        
        alerta.addTextField()
        
        let enviarAcao = UIAlertAction(title: "Enviar", style: .default)
        { [weak self, weak alerta] action in
            
            guard let palavra = alerta?.textFields?[0].text else { return }
            self?.enviar(palavra)
            
        }
        
        alerta.addAction(enviarAcao)
        present(alerta, animated: true)
    }
    
    func enviar(_ palavra: String)
    {
        listaDePalavras.insert(palavra, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        return
    }
    
    @objc func limpaLista()
    {
        listaDePalavras.removeAll()
        
        tableView.reloadData()
    }


}

