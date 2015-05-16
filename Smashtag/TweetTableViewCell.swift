//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Marcin Olek on 03.05.2015.
//  Copyright (c) 2015 Marcin Olek. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    private func updateUI() {
        // reset any existing tweet information
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetImageView?.image = nil 
        if let tweet = self.tweet
        {
            tweetTextLabel?.attributedText = textByHighlightingMentionsIn(tweet.text)
            if tweetTextLabel?.text != nil {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            }
            tweetScreenNameLabel?.text = "\(tweet.user)" // tweet.user.description
            
            if let profileImageURL = tweet.user.profileImageURL {
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { () -> Void in
                    if let imageData = NSData(contentsOfURL: profileImageURL) { // blocks main thread!
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                             self.tweetImageView?.image = UIImage(data: imageData)
                        })
                       
                    }
                })
               
            }
        }
    }
    
    private struct MentionColour {
        static let HashTagColour = UIColor.orangeColor()
        static let LinkColour = UIColor.blueColor()
        static let UserNameColour = UIColor.greenColor()
    }
    
    private func textByHighlightingMentionsIn(text:  String) -> NSAttributedString {
        var mutableText = NSMutableAttributedString(string: text)
        highlightMentions(tweet?.hashtags, usingColour: MentionColour.HashTagColour, inText: mutableText)
        highlightMentions(tweet?.urls, usingColour: MentionColour.LinkColour, inText: mutableText)
        highlightMentions(tweet?.userMentions, usingColour: MentionColour.UserNameColour, inText: mutableText)
        return mutableText
    }
    
    private func highlightMentions(mentions: [(Tweet.IndexedKeyword)]?, usingColour colour: UIColor, inText text: NSMutableAttributedString) {
        if let arr = mentions {
            for ht in arr {
                text.addAttribute(NSForegroundColorAttributeName, value: colour, range: ht.nsrange)
            }
        }
    }
   
    
    
    
}
