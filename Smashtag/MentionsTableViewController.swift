//
//  MentionsTableViewController.swift
//  Smashtag
//
//  Created by Marcin Olek on 16.05.2015.
//  Copyright (c) 2015 Marcin Olek. All rights reserved.
//

import UIKit

class MentionsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    var tweet: Tweet? {
        didSet {
            if let media = tweet?.media {
                mentions.append(Mentions(title: MentionGroupTitle.ImagesTitle, data: media.map { Mention.Image($0.url, $0.aspectRatio)}))
            }
            if let links = tweet?.urls {
                mentions.append(Mentions(title: MentionGroupTitle.LinksTitle, data: links.map { Mention.Keyword($0.keyword)}))
            }
            if let hashtags = tweet?.hashtags {
                mentions.append(Mentions(title: MentionGroupTitle.HashtagsTitle, data: hashtags.map { Mention.Keyword($0.keyword)}))
            }
            if let usernames = tweet?.userMentions {
                mentions.append(Mentions(title: MentionGroupTitle.UsersTitle, data: usernames.map { Mention.Keyword($0.keyword)}))
            }
        }
    }
    
    private var mentions: [Mentions] = []

    
    private struct MentionGroupTitle {
        static let ImagesTitle = "Images"
        static let LinksTitle = "Links"
        static let HashtagsTitle = "Hashtags"
        static let UsersTitle = "Users"
    }
    
    private struct Mentions: Printable {
        var title: String
        var data: [Mention]
        var description: String { return "\(title): \(data)" }
    }
    
    private enum Mention: Printable
    {
        case Keyword(String)
        case Image(NSURL, Double)
        var description: String {
            switch self {
            case .Keyword(let keyword): return keyword
            case .Image(let url, _): return url.path!
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return mentions.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return mentions[section].data.count
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
