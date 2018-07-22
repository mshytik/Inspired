import UIKit

// MARK: AppDelegate

@UIApplicationMain final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: UIApplicationDelegate

    var window: UIWindow?

    func application(_ app: UIApplication, didFinishLaunchingWithOptions args: Args?) -> Bool {
        configureApp()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) { DataService.shared.writeToDisk() }
    
    // MARK: Configuration
    
    private func configureApp() {
        configureWindow()
    }
    
    private func configureWindow() {
        window = Window(frame: Screen.bounds).tuned {
            $0.width(Screen.bounds.width).height(Screen.bounds.height)
            $0.backgroundColor = .white
            $0.rootViewController = SplashViewController()
            $0.makeKeyAndVisible()
        }
    }
}
