//
//  ViewController.swift
//  Projeto4
//
//  Created by Daniel Braga Barbosa on 30/01/23.
//

import UIKit

import WebKit

class ViewController: UIViewController, WKNavigationDelegate {  // the class inherits from UIViewController (the first item in the list), and promises it implements the WKNavigationDelegate protocol.  ordem aqui é realmente importante: a classe pai (superclasse) vem em primeiro lugar, então todos os protocolos implementados vêm em seguida, todos separados por vírgulas. Estamos dizendo que estamos em conformidade com apenas um protocolo aqui (WKNavigationDelegate), mas você pode especificar quantos precisar.
    
    var webView: WKWebView!
    
    override func loadView() {  // sem o override seria chamada a implementação padrão que é carregar o layout do storyboard
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        // this probably seems like pointless obfuscation from Apple, but WKWebViews don't load websites from strings like www.hackingwithswift.com, or even from a URL made out of those strings. You need to turn the string into a URL, then put the URL into an URLRequest, and WKWebView will load that. Fortunately it's not hard to do!
        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped()
    {
        let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction)
    {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

}

