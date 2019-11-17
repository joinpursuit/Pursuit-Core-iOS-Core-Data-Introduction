import UIKit

class CreateUserTableViewController: UITableViewController {
    
    // MARK:- IBOutlets
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    // MARK:- IBActions
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        guard nameIsValid(), dobIsValid() else {
            handleInvalidFields()
            return
        }
        saveUser()
        displaySuccessAlert()
    }
    
    // MARK:- Private Methods
    
    private func nameIsValid() -> Bool {
        //TODO: Complete Implementation
        return true
    }
    
    private func dobIsValid() -> Bool {
        //TODO: Complete Implementation
        return true
    }
    
    private func handleInvalidFields() {
        //TODO: Complete Implementation
    }
    
    private func saveUser() {
        let name = nameTextField.text!
        let dob = datePicker.date
        CoreDataClient.manager.createNewUser(withName: name, andDOB: dob)
    }
    
    private func displaySuccessAlert() {
        let successAlert = UIAlertController(title: "Success",
                                             message: "New user added",
                                             preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "OK",
                                             style: .default,
                                             handler: nil))
        present(successAlert,
                animated: true,
                completion: nil)
    }
}
