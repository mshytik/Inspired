import Foundation
import CoreData

// MARK: DataService

final class DataService {
    
    // MARK: Static
    
    static let shared = DataService(containerName: PathConfig.coreDataModelName)
    
    // MARK: Properties
    
    private let persistentContainer: NSPersistentContainer
    
    // MARK: Init
    
    init(containerName: String) {
        self.persistentContainer = DataService.container(name: containerName)
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
