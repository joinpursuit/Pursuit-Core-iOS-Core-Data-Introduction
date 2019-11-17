import UIKit
import CoreData

class CoreDataClient {
    
    // Static Properties
    
    static let manager = CoreDataClient()
    
    // Internal Methods
    
    func createNewUser(withName name: String, andDOB dob: Date) {
        let newUser = User(context: managedObjectContext)
        newUser.name = name
        newUser.dob = dob
        appDelegate.saveContext()
    }

    func getUsers(onCompletion: @escaping (Result<[User], Error>) -> Void) {
        do {
            guard let users = try managedObjectContext.fetch(User.fetchRequest()) as? [User] else {
                fatalError("Developer Error: User.fetchRequest returned an unexpected type")
            }
            onCompletion(.success(users))
        }
        catch {
            onCompletion(.failure(error))
        }
    }
    
    func createNewPost(withTitle title: String, number: Double, user: User) {
        let newPost = Post(context: managedObjectContext)
        newPost.title = title
        newPost.number = number
        newPost.user = user
        appDelegate.saveContext()
    }
    
    func getPosts(onCompletion: @escaping (Result<[Post], Error>) -> Void) {
        do {
            guard let posts = try managedObjectContext.fetch(Post.fetchRequest()) as? [Post] else {
                fatalError("Developer Error: Post.fetchRequest returned an unexpected type")
            }
            onCompletion(.success(posts))
        }
        catch {
            onCompletion(.failure(error))
        }
    }
    
    // Private Properties and Initializers
    
    private init() {}
    
    private var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    private var managedObjectContext: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
}
