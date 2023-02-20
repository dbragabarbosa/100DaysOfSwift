//
//  DetailViewController.swift
//  Projeto7
//
//  Created by Daniel Braga Barbosa on 13/02/23.
//

import UIKit

import WebKit

class DetailViewController: UIViewController
{

    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView()
    {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let detailItem = detailItem else { return }
        // That guard at the beginning unwraps detailItem into itself if it has a value, which makes sure we exit the
//        method if for some reason we didn’t get any data passed into the detail view controller.

//        Nota: É muito comum desembrulhar variáveis usando o mesmo nome, em vez de criar pequenas variações. Neste
//        caso, poderíamos ter usado guard let unwrappedItem = detailItem, mas isso não é melhor.
        
        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
