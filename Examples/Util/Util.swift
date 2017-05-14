import Foundation
import UIKit

enum JSONError: Error {
	case missing(String)
	case invalid(String, Any)
}
class Util: NSObject {

	static func getEstimoteSession() -> URLSession {
		//		let devicesEndpoint: String = url
		//		guard let url = URL(string: devicesEndpoint) else {
		//			print("Error: cannot create URL")
		//			return
		//		}
		//let urlRequest = URLRequest(url: url)
		
		let basic = GeneralSettings.getName() + ":" + GeneralSettings.getPassword()
		let data = (basic).data(using: String.Encoding.utf8)
		let base64 = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
		let headers = [
			"Authorization": "Basic " + base64,
			"Accept": "application/json"
		]
		let config = URLSessionConfiguration.default
		config.httpAdditionalHeaders = headers
		let session = URLSession(configuration: config)
		return session
	}
	
    static func nav(_ name: String) {
		var whereTo = name
		if (whereTo == "Menu") { whereTo = "Home" }
		print(whereTo)
		
        let storyboard = UIStoryboard(name: whereTo, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: whereTo)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
        appDelegate.window?.makeKeyAndVisible()
        vc.view.alpha = 0.0
        UIView.animate(withDuration: 0.2,
            delay: 0.0,
            options: .curveEaseIn,
            animations: {
                vc.view.alpha = CGFloat(1.0)
            },
            completion: {
                (value: Bool) in
        });
    }

}
