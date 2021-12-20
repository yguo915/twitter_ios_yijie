//
//  TweetCell.swift
//  Twitter
//
//  Created by Yijie Guo on 12/13/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    

    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func favedTweet(_ sender: Any) {
        let tobeFaved = !faved
        if(tobeFaved){
            TwitterAPICaller.client?.favedTweet(tweetID: tweetID, success: {
                self.setFaved(isFaved: true)
            }, failure: { (error) in
                print("Favourite did not succeed \(error)")
            })
        }
        else{
            TwitterAPICaller.client?.unfavedTweet(tweetID: tweetID, success: {
                self.setFaved(isFaved: false)
            }, failure: { (error) in
                print("Unfavourite did not succeed \(error)")
            })
            
        }
        
    }
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
            self.setRetweeted(isRetweeted: true)
        }, failure: { (error) in
            print("Retweet did not succeed \(error)")
        })
    }
    
    
    var faved:Bool = false
    var tweetID:Int = -1
    var retweeted:Bool = false
    
    func setFaved( isFaved:Bool){
        faved = isFaved
        if faved{
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted( isRetweeted:Bool){
        if (isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
