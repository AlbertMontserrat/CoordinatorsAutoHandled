//
//  SceneDelegate.swift
//  test-auto-coordinator
//
//  Created by Albert Montserrat on 9/6/21.
//

import UIKit

var logging: ((_ text: String, _ color: UIColor) -> Void)?

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var secondWindow: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let vc = LoggingVC()
        logging = vc.loggingCallback
        
        let navigationController = UINavigationController()
        GenericCoordinator(
            presentationStyle: .push(
                navigationController: navigationController
            )
        ).start()

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        
        let floatingWindow = FloatingWindow(windowScene: windowScene)
        floatingWindow.rootViewController = vc
        self.secondWindow = floatingWindow
        floatingWindow.makeKeyAndVisible()
        floatingWindow.windowLevel = .statusBar + 1
    }
}

private class FloatingWindow: UIWindow {

    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        backgroundColor = nil
        frame = UIScreen.main.bounds
        isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        false
    }

}
