import UIKit

class PostsTableViewController: UITableViewController {

    // MARK:- Internal Properties
    
    var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }

    var user: User?

    // MARK:- Lifecycle Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPosts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPosts()
    }
    
    // MARK:- Private Properties

    private func loadPosts() {
        if let passedInUser = user {
            let userPosts = passedInUser.posts?.allObjects as! [Post]
            posts = userPosts
        } else {
            CoreDataClient.manager.getPosts { [weak self] (result) in
                switch result {
                case let .success(fetchedPosts):
                    self?.posts = fetchedPosts
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    // MARK:- TableViewDataSource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = "\(post.user?.name ?? "Unknown") - \(post.title ?? "No title")"
        cell.detailTextLabel?.text = "\(post.number)"
        return cell
    }
}

