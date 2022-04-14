//

import UIKit
import JsHelper

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = makeWindow(for: scene, with: MainViewController()) {
            self.window = windowScene
        }
    }
}
