//
//  ViewController.swift
//  Projeto7
//
//  Created by Daniel Braga Barbosa on 11/02/23.
//

import UIKit

class ViewController: UITableViewController
{

//    var petitions = [String]()
    var petitions = [Petition]()
    
    var petitionsProcuradas = [Petition]()
    
    var stringProcurada = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
//        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        let urlString: String

        if navigationController?.tabBarItem.tag == 0
        {
//            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }
        else
        {
//            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }

        if let url = URL(string: urlString)
        {
            if let data = try? Data(contentsOf: url)
            {
                // we're OK to parse!
                parse(json: data)
            }
            else
            {
                showError()
            }
        }
        else
        {
            showError()
        }

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(creditos))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filtroDePeticoes))
        
    }
    
    @objc func filtroDePeticoes()
    {
        let alerta = UIAlertController(title: "Digite o que você procura:", message: nil, preferredStyle: .alert)
        
        alerta.addTextField()
        
        let enviar = UIAlertAction(title: "Enviar", style: .default) { [weak self, weak alerta] action in
            
            guard let resposta = alerta?.textFields?[0].text else { return }
            
            self?.stringProcurada.insert(resposta, at: 0)

        }
        
        alerta.addAction(enviar)
        
        present(alerta, animated: true)
    }
    
    @objc func creditos()
    {
        let alerta = UIAlertController(title: "Todos os dados vêm da API We The People da Whitehouse.", message: nil, preferredStyle: .alert)
        
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alerta, animated: true)
    }
    
    func parse(json: Data)
    {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json)
        {
            petitions = jsonPetitions.results
            
            print(stringProcurada)
            
            petitionsProcuradas = petitions
            
            tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = petitions[indexPath.row]
        
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    
    func showError()
    {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your conection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

}

