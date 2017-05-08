import UIKit
import CoreLocation

class ProzimityViewController: UIViewController, CLLocationManagerDelegate {

	
	@IBAction func Menu(_ sender: Any) {
		Util.nav("Menu")
	}
	
	@IBOutlet weak var detail: UILabel!
	
	let locationManager = CLLocationManager()
	//let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "Estimotes")
	
	let colors = [
		45325: UIColor(red: 231/255, green: 220/255, blue:  48/255, alpha: 1),	//lemon
		24552: UIColor(red: 142/255, green:  45/255, blue:  89/255, alpha: 1),	//beetroot
		31138: UIColor(red: 240/255, green: 159/255, blue: 194/255, alpha: 1),	//candy
		41963: UIColor(red: 119/255, green: 186/255, blue: 227/255, alpha: 1),	//ice
		22353: UIColor(red:  74/255, green:  56/255, blue: 131/255, alpha: 1),	//bluberry
		26391: UIColor(red: 175/255, green: 207/255, blue: 171/255, alpha: 1)		//mint
	]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		locationManager.delegate = self
		if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse) {
			locationManager.requestWhenInUseAuthorization()
		}
		let uuid = "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
		let major:UInt16 = 32254
		let minor:UInt16 = 45325
		let region = CLBeaconRegion(proximityUUID:UUID(uuidString: uuid)!,major:major,minor:minor,identifier:"Estimotes")
		locationManager.startRangingBeacons(in: region)
	}
	
	func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
//		print(beacons.count)
		let knownBeacons = beacons.filter{ $0.proximity != CLProximity.unknown }
		if (knownBeacons.count > 0) {
			let closestBeacon = knownBeacons[0] as CLBeacon
//			print(closestBeacon.rssi)
			self.view.backgroundColor = self.colors[closestBeacon.minor.intValue]
			//detail.text = String(closestBeacon.proximity)
			detail.text = "rssi: " + String(closestBeacon.rssi)
			
//			uuid
//			major
//			minor
//			rssi
			
		}
	}

}
