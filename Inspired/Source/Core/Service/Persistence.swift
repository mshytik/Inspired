import Foundation
import CoreData

// MARK: Persistence

final class Persistence {
    
    // MARK: Static
    
    static let shared = Persistence(containerName: PathConfig.coreDataModelName)
    
    // MARK: Properties
    
    private let persistentContainer: NSPersistentContainer
    
    // MARK: Init
    
    init(containerName: String) {
        self.persistentContainer = Persistence.container(name: containerName)
    }
    
    func writeToDisk() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: Private helpers
    
    private static func container(name: String) -> NSPersistentContainer {
        let container = NSPersistentContainer(name: name)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }
}
