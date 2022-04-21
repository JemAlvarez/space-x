//

import UIKit
import JsHelper

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let window = makeWindow(for: scene, with: TabBarVC()) {
            self.window = window

            // request review
            requestStoreReview()
        }
    }
}

extension SceneDelegate {
    func requestStoreReview() {
        var numTimesOpened = UserDefaults.standard.integer(forKey: UserDefaults.Keys.numberOfTimesOpened.rawValue)
        numTimesOpened += 1
        UserDefaults.standard.set(numTimesOpened, forKey: UserDefaults.Keys.numberOfTimesOpened.rawValue)

        switch numTimesOpened {
        case 10:
            UIApplication.requestStoreReview()
        case 25:
            UIApplication.requestStoreReview()
        case 50:
            UIApplication.requestStoreReview()
        case 100:
            UIApplication.requestStoreReview()
        case 150:
            UIApplication.requestStoreReview()
        case 200:
            UIApplication.requestStoreReview()
        case 250:
            UIApplication.requestStoreReview()
        case 300:
            UIApplication.requestStoreReview()
        case 400:
            UIApplication.requestStoreReview()
        default:
            break
        }
    }
}
