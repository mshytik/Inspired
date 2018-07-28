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
        Persistence.shared.writeToDisk()
    }
    
    // MARK: Configuration
    
    private func configureApp() {
        configureWindow()
        NavigationController.applyDefaultAppearance()
    }
    
    private func configureWindow() {
        window = UIWindow(frame: Screen.bounds).tuned {
            $0.width(Screen.width).height(Screen.height)
            $0.backgroundColor = Color.Bg.screen
            $0.rootViewController = SplashViewController()
            $0.makeKeyAndVisible()
        }
    }
}
