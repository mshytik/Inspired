import UIKit

// MARK: AppDelegate

@UIApplicationMain final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: UIApplicationDelegate

    var window: UIWindow?

    func application(_ app: UIApplication, didFinishLaunchingWithOptions args: Args?) -> Bool {
        configureApp()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        DataService.shared.writeToDisk()
    }
    
    // MARK: Configuration
    
    private func configureApp() {
        configureWindow()
    }
    
    private func configureWindow() {
        window = UIWindow(frame: Screen.bounds).tuned {
            $0.backgroundColor = .white
            $0.rootViewController = ViewController()
            $0.makeKeyAndVisible()
        }
    }
}
