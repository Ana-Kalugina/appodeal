//
//  AppDelegate.swift
//  KaluginaTask2
//
//  Created by  MAC on 8/27/20.
//

import UIKit
import Appodeal
import StackConsentManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private struct AppodealConstants {
        static let key: String = "dee74c5129f53fc629a44a690a02296694e3eef99f2d3a5f"
        static let adTypes: AppodealAdType = [.interstitial, .rewardedVideo, .banner, .nativeAd]
        static let logLevel: APDLogLevel = .debug
        static let testMode: Bool = true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        synchroniseConsent()
        configureAppearance()
        return true
    }

    // MARK: Appodeal Initialization
    private func initializeAppodealSDK() {
        Appodeal.setTestingEnabled(AppodealConstants.testMode)
        Appodeal.setLogLevel(AppodealConstants.logLevel)
        Appodeal.setAutocache(true, types: AppodealConstants.adTypes)
        let consent = STKConsentManager.shared().consentStatus != .nonPersonalized
        Appodeal.initialize(
            withApiKey: AppodealConstants.key,
            types: AppodealConstants.adTypes,
            hasConsent: consent
        )
    }
    // MARK: Consent manager
    private func synchroniseConsent() {
        STKConsentManager.shared().synchronize(withAppKey: AppodealConstants.key) { error in
            error.map { print("Error while synchronising consent manager: \($0)") }
            guard STKConsentManager.shared().shouldShowConsentDialog == .true else {
                self.initializeAppodealSDK()
                return
            }
            STKConsentManager.shared().loadConsentDialog { [unowned self] error in
                error.map { print("Error while loading consent dialog: \($0)") }
                guard let controller = UIViewController() as? ViewController, STKConsentManager.shared().isConsentDialogReady else {
                    self.initializeAppodealSDK()
                    return
                }
                STKConsentManager.shared().showConsentDialog(fromRootViewController: controller,
                                                             delegate: self)
            }
        }
    }
    // MARK: Appearance
    private func configureAppearance() {
        let navBarAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]

        UINavigationBar.appearance().tintColor = .white
        UIBarButtonItem.appearance().setTitleTextAttributes(navBarAttributes, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(navBarAttributes, for: .highlighted)

        UITabBar.appearance().tintColor = .white
        if #available(iOS 10.0, *) {
            UITabBar.appearance().unselectedItemTintColor = .lightGray
        }
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: STKConsentManagerDisplayDelegate {
    func consentManagerWillShowDialog(_ consentManager: STKConsentManager) {}

    func consentManager(_ consentManager: STKConsentManager, didFailToPresent error: Error) {
        initializeAppodealSDK()
    }

    func consentManagerDidDismissDialog(_ consentManager: STKConsentManager) {
        initializeAppodealSDK()
    }
}
