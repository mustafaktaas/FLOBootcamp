//
//  AuthorPageViewController.swift
//  UnluAlintilarOdev
//
//  Created by Mustafa Aktas on 19.06.2023.
//

import UIKit

class AuthorPageViewController: UIViewController {

    @IBOutlet weak var authorArticleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var authorPictureImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let quote = Quote.randomQuote()
        
        authorArticleLabel.text = quote.quote
        authorNameLabel.text = quote.authorName
        
        if quote.gender.lowercased() == "woman" {
            authorPictureImageView.image = UIImage(named: "kadin")
        } else if quote.gender.lowercased() == "male" {
            authorPictureImageView.image = UIImage(named: "erkek")
        } else {
            // Handle other genders or unknown cases here
            // For example, you can set a default image
            authorPictureImageView.image = UIImage(named: "default")
        }

    }
    
    @IBAction func newArticleButton(_ sender: UIButton) {
        let quote = Quote.randomQuote()
        
        authorArticleLabel.text = quote.quote
        authorNameLabel.text = quote.authorName
        
        if quote.gender.lowercased() == "woman" {
            authorPictureImageView.image = UIImage(named: "kadin")
        } else if quote.gender.lowercased() == "male" {
            authorPictureImageView.image = UIImage(named: "erkek")
        } else {
            // Handle other genders or unknown cases here
            // For example, you can set a default image
            authorPictureImageView.image = UIImage(named: "default")
        }
    }
    

}
