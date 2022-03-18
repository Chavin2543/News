//
//  ArticleModel.swift
//  News
//
//  Created by chavin Panicharoen on 19/3/2565 BE.
//

import Foundation

protocol ArticleModelAProtocol {
    func articlesRetrieved(_ articles:[Article])
}

class ArticleModel {
    
    var delegate:ArticleModelAProtocol?
    
    func getArticle() {
        // Fire off the request to the API
        
        //Create a String URL
        let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2022-02-18&sortBy=publishedAt&apiKey=517d1e7ee1d54b91bec2cdea232d1701"
        //Create a URL Object
        guard let url = URL(string: urlString) else {return}
        //Get the URL Session
        URLSession.shared.dataTask(with: url) { [weak self] value, response, error in
            guard let value = value else {return}
            if error != nil {
                return
            }
            do {
                print("Data retrieved !!")
                let returnedValue = try JSONDecoder().decode(ArticleService.self, from: value)
                
                guard let articles = returnedValue.articles else {return}
                
                DispatchQueue.main.async {
                    self?.delegate?.articlesRetrieved(articles)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
        
        //Create the data task
        
        //Start the dataTask
        
        //Parse the returned JSON into article instances and pass it back to the view controller with the protocol and delegate pattern
        delegate?.articlesRetrieved([Article]())
    }
}
