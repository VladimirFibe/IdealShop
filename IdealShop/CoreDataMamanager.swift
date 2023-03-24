import UIKit
import CoreData

// MARK: - CRUD
public final class CoreDataMamanager: NSObject {
    public static let shared = CoreDataMamanager()
    private override init() {}

    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }

    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }

    public func createPerson(withEmail email: String, firstname: String, lastname: String) {
        guard let personEntityDescription = NSEntityDescription.entity(forEntityName: "Person", in: context)
        else {return}
        let person = Person(entity: personEntityDescription, insertInto: context)
        person.email = email
        person.firstname = firstname
        person.lastname = lastname
        person.password = "123456"
        appDelegate.saveContext()
    }
    public func fetchPerson(firstname: String) -> Person? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "firstname == %@", firstname)
        do {
            let persons = try? context.fetch(fetchRequest) as? [Person]
            return persons?.first
        }
    }
}
