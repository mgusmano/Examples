import Foundation
import UIKit

enum MyDataError: Error {
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
        
        
        //        if(animate) {
        //                    UIView.transition(with: (appDelegate.window?.rootViewController?.view)!, duration: 2.3, options: .transitionCrossDissolve, animations: {
        //                    }, completion: { completed in
        //                    })
        //        }
        
        //            snapshot.layer.opacity = 0;
        //            snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
       
        
        //        var animate = false
        //        if (appDelegate.window?.rootViewController != nil) {
        //            print(appDelegate.window?.rootViewController as Any)
        //            animate = true
        //        }
        
        //appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        //appDelegate.window?.backgroundColor = UIColor.white
        
    }
    
}
