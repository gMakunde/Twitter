//
//  TweetCell.swift
//  Twitter
//
//  Created by George Martin on 2/16/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var retweet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func likeTweet(_ sender: Any) {
        let toBeLiked = !liked
        if (toBeLiked){
            TwitterAPICaller.client?.likeTweet(tweetId: tweetId, success: {
                self.setLike(true)
            }, failure: { (error) in
                print("like did not suceed: \(error)")
            })
            
        } else {
                TwitterAPICaller.client?.unlikeTweet(tweetId: tweetId, success: {
                    self.setLike(false)
                }, failure: { (error) in
                    print("unlike did not succeed: \(error)")
                })
        }
    }
    
    var liked:Bool = false
    var tweetId:Int = -1
    
    func setLike(_ isLiked:Bool) {
        liked = isLiked
        if (liked) {
            like.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            like.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    var retweeted:Bool = false
    func setRetweet(_ isRetweeted:Bool){
        retweeted = isRetweeted
        if (retweeted){
            retweet.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            retweet.isEnabled = false
        } else{
            retweet.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            retweet.isEnabled = true
        }
    }
    
    @IBAction func retweetTweet(_ sender: Any) {
        let toBeRetweeted = !retweeted
        if (toBeRetweeted){
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                self.setRetweet(true)
            }, failure: { (error) in
                print("retweet did not succeed: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unretweet(tweetId: tweetId, success: {
                self.setRetweet(false)
            }, failure: { (error) in
                print("unretweet did not succeed: \(error)")
            })
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
