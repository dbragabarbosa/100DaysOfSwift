//
//  ViewController.swift
//  Project7
//
//  Created by Daniel Braga Barbosa on 18/07/22.
//

import UIKit

class ViewController: UITableViewController
{
    var petitions = [Petition]()
    var petitionsSelect = [Petition]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        let urlString: String

        if navigationController?.tabBarItem.tag == 0
        {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else
        {
            // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }

        
        DispatchQueue.global(qos: .userInitiated).async
        {
            if let url = URL(string: urlString)
            {
                if let data = try? Data(contentsOf: url)
                {
                    self.parse(json: data)
                    return
                }
            }
            
            self.showError()
        }
        
    }
    
    func showError()
    {
        DispatchQueue.main.async
        {
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    func parse(json: Data)
    {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json)
        {
            petitions = jsonPetitions.results
            petitionsSelect = petitions
            
            DispatchQueue.main.async
            {
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
//        return petitions.count
        return petitionsSelect.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}

