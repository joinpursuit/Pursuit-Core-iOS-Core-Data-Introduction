import UIKit

class CreatePostTableViewController: UITableViewController {

    // MARK:- IBOutlets

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var usersPickerView: UIPickerView!

    // MARK:- Internal Properties
    
    var users = [User]() {
        didSet {
            usersPickerView.reloadAllComponents()
        }
    }
    
    // MARK:- Lifecycle Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersPickerView.delegate = self
        usersPickerView.dataSource = self
        loadUsers()
    }
    
    // MARK:- IBActions

    @IBAction func submitButtonPressed(_ sender: Any) {
        guard titleIsValid(), postNumIsValid() else {
            handleInvalidFields()
            return
        }
        
        let postTitle = titleTextField.text!
        let postNum = Double(numberTextField.text!)!
        let postUser = users[usersPickerView.selectedRow(inComponent: 0)]

        CoreDataClient.manager.createNewPost(withTitle: postTitle, number: postNum, user: postUser)
        displaySuccessAlert()
    }

    // MARK:- Private Methods
    
    private func titleIsValid() -> Bool {
        //TODO: Complete Implementation
        return true
    }
    
    private func postNumIsValid() -> Bool {
        //TODO: Complete Implementation
        return true
    }
    
    private func handleInvalidFields() {
        //TODO: Complete Implementation
    }
    
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
    
    private func displaySuccessAlert() {
        let successAlert = UIAlertController(title: "Success",
                                             message: "New post added",
                                             preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "OK",
                                             style: .default,
                                             handler: nil))
        present(successAlert,
                animated: true,
                completion: nil)
    }
}

// MARK:- UIPickerView Delegate and DataSource

extension CreatePostTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return users[row].name
    }
}

