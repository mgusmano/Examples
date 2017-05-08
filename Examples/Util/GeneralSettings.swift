import UIKit

class GeneralSettings: NSObject {

	class func setName(value: String) {
		UserDefaults.standard.set(value, forKey: "name")
		UserDefaults.standard.synchronize()
	}
	class func getName() -> String {
		return UserDefaults.standard.string(forKey: "name")!
	}
	
	class func setPassword(value: String) {
		UserDefaults.standard.set(value, forKey: "password")
		UserDefaults.standard.synchronize()
	}
	class func getPassword() -> String {
		return UserDefaults.standard.string(forKey: "password")!
	}
	
	
	
    class func saveOnboardingFinished() {
        UserDefaults.standard.set(true, forKey: "onboarding")
        UserDefaults.standard.synchronize()
    }
    class func saveOnboardingNotFinished() {
        UserDefaults.standard.set(false, forKey: "onboarding")
        UserDefaults.standard.synchronize()
    }
    class func isOnboardingFinished() -> Bool {
        return UserDefaults.standard.bool(forKey: "onboarding")
    }
    
}
