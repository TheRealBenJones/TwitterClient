//
//  TweetViewController.swift
//  TwitterClient
//
//  Created by Ben Jones on 10/30/16.
//  Copyright © 2016 Ben Jones. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var replyButton: AnimatedUIButton!
    @IBOutlet weak var retweetButton: AnimatedUIButton!
    @IBOutlet weak var favoriteButton: AnimatedUIButton!
    var tweet : Tweet?
    
    
    @IBOutlet weak var favNumber: UILabel!
    @IBOutlet weak var retweetNumber: UILabel!
    @IBOutlet weak var userScreenName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var tweetText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        favoriteButton.imageColorOn = TwitterColor.red
        favoriteButton.addTarget(self, action: #selector(likeButtonPressed(sender:)), for: .touchUpInside)
        favoriteButton.isSelected = tweet?.favorited ?? false
        
        
        self.userName.text = self.tweet?.user.name
        self.userScreenName.text = "@\(self.tweet?.user.screenName ?? "")"
        DispatchQueue.main.async {
            self.userImage.setImageWith(self.tweet!.user.profileImageUrl)
            
            self.userImage.layer.cornerRadius = 5.0
            self.userImage.clipsToBounds = true
        }
        self.tweetText.text = self.tweet?.text
        
        
        
        
    }

    override func viewDidLayoutSubviews() {

        self.replyButton.updateLayers()
        self.retweetButton.updateLayers()
        self.favoriteButton.updateLayers()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func likeButtonPressed(sender: AnimatedUIButton) {
        if sender.isSelected {
            // deselect
            sender.deselect()
        } else {
            // select with animation
            sender.select()
            tweet?.favorite()
        }
    }
    
    @IBAction func replyButtonPressed(_ sender: AnyObject) {
        let newTweetViewController = NewTweetViewController(replyTo: tweet)
        self.present(newTweetViewController, animated: true, completion: nil)
    }
    
    @IBAction func retweetButtonPressed(_ sender: AnyObject) {
        
    }

}
