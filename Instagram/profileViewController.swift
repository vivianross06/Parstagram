//
//  profileViewController.swift
//  Instagram
//
//  Created by Vivian Ross on 5/6/21.
//

import UIKit
import Parse
import AlamofireImage

class profileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profileTableView: UITableView!
    
    var posts = [PFObject]()
    var numberOfPosts: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileTableView.delegate = self
        profileTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        numberOfPosts = 5
        let query = PFQuery(className: "Posts")
        query.whereKey("author", equalTo:PFUser.current()!)
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = numberOfPosts
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.profileTableView.reloadData()
            }
        }
    }
    
    func loadMorePosts(){
        numberOfPosts = numberOfPosts + 5
        let query = PFQuery(className: "Posts")
        query.whereKey("author", equalTo:PFUser.current()!)
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = numberOfPosts
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.profileTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == posts.count  && posts.count == numberOfPosts{
            print("loading more posts")
            loadMorePosts()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTableView.dequeueReusableCell(withIdentifier: "profilePostCell") as! profilePostCell
        
        let post = posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        cell.profileName.text = user.username
        
        cell.profilePostCaption.text = post["caption"] as! String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.profilePostImage.af_setImage(withURL: url)
        
        return cell
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
