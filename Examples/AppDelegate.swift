import LocalAuthentication
import UIKit
import UserNotifications
import FacebookCore

// theme: https://www.raywenderlich.com/156036/uiappearance-tutorial-getting-started


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	let defaults = UserDefaults.standard

	
	// Push notification received
	func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
		// Print notification payload data
		print("Push notification received: \(data)")
		Util.nav("Beacons")
	}
	
	
	// Called when APNs has assigned the device a unique token
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		// Convert token to string
		let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
		
		// Print it to console
		print("APNs device token: \(deviceTokenString)")
		
		// Persist it in your backend in case it's new
	}
	
	// Called when APNs failed to register the device for push notifications
	func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
		// Print the error to console (you should alert the user that registration failed)
		print("APNs registration failed: \(error)")
	}
	
	
	
	
	public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
		return SDKApplicationDelegate.shared.application(application, open:url, sourceApplication:sourceApplication, annotation:annotation)
	}
	
	
	

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
		
		//defaults.registerForRemoteNotifications()
		
		//touchID()
		
		let name = "mgusmano-yahoo-com-s-your--g8e"
		let password = "a3bbba239cefe97f93acbc909dfb1c9b"
		GeneralSettings.setName(value: name)
		GeneralSettings.setPassword(value: password)
		
		//curl -X GET 'https://cloud.estimote.com/v2/devices' -u "mgusmano-yahoo-com-s-your--g8e:a3bbba239cefe97f93acbc909dfb1c9b" -H "Accept: application/json"
		
		self.window = UIWindow(frame:UIScreen.main.bounds)
		self.window!.backgroundColor = Layout.mint
        
		var navName = ""
		if GeneralSettings.isOnboardingFinished() == false {
			navName = "Onboarding"
		} else {
			navName = "Menu"
		}
		navName = "Home"  //real start
		//navName = "Orientation"  //for testing purposes
		Util.nav(navName)


		
		
		// iOS 10 support
		if #available(iOS 10, *) {
			UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
			application.registerForRemoteNotifications()
		}
			// iOS 9 support
		else if #available(iOS 9, *) {
			UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
			UIApplication.shared.registerForRemoteNotifications()
		}
			// iOS 8 support
		else if #available(iOS 8, *) {
			UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
			UIApplication.shared.registerForRemoteNotifications()
		}
			// iOS 7 support
		else {
			application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
		}
		
		
		
		
		
		
		
		return true
	}
	
	func touchID() {
		let authenticationContext = LAContext()
		
		var error:NSError?
		guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
			print("No Biometric Sensor Has Been Detected. This device does not support Touch Id.")
			return
		}
		
		authenticationContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Only device owner is allowed", reply: { (success, error) -> Void in
			
			if( success ) {
				print("Fingerprint recognized. You are a device owner!")
			} else {
				
				// Check if there is an error
				if let errorObj = error {
					print("Error took place. \(errorObj.localizedDescription)")
				}
				
			}
		})
		
	}
	
	

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

