//
//  ViewController.swift
//  News
//
//  Created by chavin Panicharoen on 19/3/2565 BE.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let model = ArticleModel()
    var articles:[Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view controller as the datasource and delegate of the tableview
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        model.delegate = self
        model.getArticle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Detect the indexpath of article the user selected
        let indexPath = tableView.indexPathForSelectedRow
        guard indexPath != nil else {return}
        // Get the article user tapped on
        let article = articles[indexPath!.row]
        // Get the reference to the detail view controller
        let detailVC = segue.destination as! DetailsViewController
        // Pass the article to the detail view controller
        detailVC.articleUrl = article.url!
    }
}

extension ViewController:ArticleModelAProtocol {
    //MARK: - Article Model Protocol Methods
    func articlesRetrieved(_ articles: [Article]) {
        self.articles = articles
        
        tableView.reloadData()
    }
}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticelCell
        // Customize a cell
        
            //Get the article that tableview is asking about
        let article = articles[indexPath.row]
        
        
        cell.displayArticle(article)
        // Return a cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row : \(articles[indexPath.row].title ?? "")")
    }
}
