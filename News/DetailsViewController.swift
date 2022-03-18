//
//  DetailsViewController.swift
//  News
//
//  Created by chavin Panicharoen on 19/3/2565 BE.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    
    var articleUrl:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Check that there's a url
        guard articleUrl != nil else {return}
        
        if articleUrl != nil {
            //Start spinner
            spinner.alpha = 1
            spinner.startAnimating()
        
            webView.load(URLRequest(url: URL(string: articleUrl!)!))
        }
        
        
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

extension DetailsViewController:WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //Stop the spinner and hide it
        spinner.stopAnimating()
        spinner.alpha = 0
    }
    
}
