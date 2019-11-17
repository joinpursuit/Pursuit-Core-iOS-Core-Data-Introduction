import UIKit

class UsersTableViewController: UITableViewController {

    // MARK:- Internal Properties
    
    var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK:- Lifecycle Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUsers()
    }
    
    // MARK:- Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PostsTableViewController {
            let selectedUser = users[tableView.indexPathForSelectedRow!.row]
            destination.user = selectedUser
        }
    }
    
    // MARK:- Private Methods

    private func loadUsers() {
        CoreDataClient.manager.getUsers { [weak self] (result) in
            switch result {
            case let .success(fetchedUsers):
                self?.users = fetchedUsers
            case let .failure(error):
                print(error)
            }
        }
    }
    
    // MARK:- TableViewDataSource Conformance

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        return cell
    }
}
