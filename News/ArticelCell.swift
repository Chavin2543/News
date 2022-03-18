//
//  ArticelCell.swift
//  News
//
//  Created by chavin Panicharoen on 19/3/2565 BE.
//

import UIKit

class ArticelCell: UITableViewCell {

    
    @IBOutlet weak var articleImageView: UIImageView!
    
    @IBOutlet weak var headlineLabel: UILabel!
    
    var articleToDisplay:Article?
    
    func displayArticle(_ article:Article) {
        // Clean up the cell before displaying the next article
        articleImageView.image = nil
        articleImageView.alpha = 0
        headlineLabel.alpha = 0
        headlineLabel.text = ""
        // Keep a reference to the article
        articleToDisplay = article
        // Set the headline
        headlineLabel.text = articleToDisplay!.title
        // Animate the label into view
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) {
            self.headlineLabel.alpha = 1
        }

        
        // Create a url string
        guard let urlString = articleToDisplay?.urlToImage else {return}
        
        // Check the CacheManager Before downloading any imageData
        if let imageData = CacheManager.retrieveData(urlString) {
            //There's image data set the image view and return
            articleImageView.image = UIImage(data: imageData)
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) {
                self.articleImageView.alpha = 1
            }

            return
        }
        
        // Create a url
        guard let url = URL(string: urlString) else {return}
        // Get URLSession
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if error == nil, data != nil {
                //SaveData into Cache
                CacheManager.saveData(urlString, data!)
                
                //Check if the urlString that the datatask went off to download matches the article in the cell is set to display
                if self?.articleToDisplay!.urlToImage == urlString {
                    DispatchQueue.main.async {
                        self?.articleImageView.image = UIImage(data: data!)
                        
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseInOut) {
                            self?.articleImageView.alpha = 1
                        }
                    }
                }
            }
        }
        .resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
