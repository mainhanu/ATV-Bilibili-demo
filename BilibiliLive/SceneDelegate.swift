import AVFoundation
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        AppDelegate.shared.window = window

        if ApiRequest.isLogin() {
            if let expireDate = ApiRequest.getToken()?.expireDate {
                if expireDate.timeIntervalSinceNow < 60 * 60 * 30 {
                    ApiRequest.refreshToken()
                }
            } else {
                ApiRequest.refreshToken()
            }
            window.rootViewController = BLTabBarViewController()
        } else {
            window.rootViewController = LoginViewController.create()
        }
        window.makeKeyAndVisible()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
    }
}
