import UIKit
import CoreLocation

class CloudDetailViewController: UIViewController, CLLocationManagerDelegate {

	@IBOutlet weak var colorLabel: UILabel!
	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var identifierLabel: UILabel!
	@IBOutlet weak var iconImageView: UIImageView!
	
	@IBOutlet weak var minorLabel: UILabel!
	@IBOutlet weak var majorLabel: UILabel!
	@IBOutlet weak var uuidLabel: UILabel!
	
	@IBOutlet weak var rssiLabel: UILabel!
	
	
	let locationManager = CLLocationManager()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		locationManager.delegate = self
		if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse) {
			locationManager.requestWhenInUseAuthorization()
		}
		refreshUI()
	}
	
	var region: CLBeaconRegion? = nil
	
	override func viewDidAppear(_ animated: Bool) {
		print("appear " + device.color)

		let major: CLBeaconMajorValue = UInt16(device.major)
		let minor: CLBeaconMajorValue = UInt16(device.minor)
		region = CLBeaconRegion(proximityUUID: UUID(uuidString: device.uuid)!,
		                            major: major,
		                            minor: minor,
		                            identifier: device.color
		)
		locationManager.startRangingBeacons(in: region!)

	}
	
	override func viewDidDisappear(_ animated: Bool) {
		print("disappear " + device.color)

		locationManager.stopRangingBeacons(in: region!)
		self.view.backgroundColor = UIColor.white
		rssiLabel?.text = "rssi: " + ""
		
	}

	let colors = [
		45325: UIColor(red: 231/255, green: 220/255, blue:  48/255, alpha: 1),	//lemon
		24552: UIColor(red: 142/255, green:  45/255, blue:  89/255, alpha: 1),	//beetroot
		31138: UIColor(red: 240/255, green: 159/255, blue: 194/255, alpha: 1),	//candy
		41963: UIColor(red: 119/255, green: 186/255, blue: 227/255, alpha: 1),	//ice
		22353: UIColor(red:  74/255, green:  56/255, blue: 131/255, alpha: 1),	//bluberry
		26391: UIColor(red: 175/255, green: 207/255, blue: 171/255, alpha: 1)		//mint
	]
	
	
	var device: Device! {
			didSet (newDevice) {
				self.refreshUI()
			}
	}
	
	func refreshUI() {
			colorLabel?.text = device.color
			typeLabel?.text = device.type
			identifierLabel?.text = device.identifier
			iconImageView?.image = device.iconImage()
			uuidLabel?.text = device.uuid
			majorLabel?.text = "\(device.major)"
			minorLabel?.text = "\(device.minor)"
	}
	
	
	func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
		//		print(beacons.count)
		let knownBeacons = beacons.filter{ $0.proximity != CLProximity.unknown }
		if (knownBeacons.count > 0) {
			let closestBeacon = knownBeacons[0] as CLBeacon
			//			print(closestBeacon.rssi)
			self.view.backgroundColor = self.colors[closestBeacon.minor.intValue]
			//detail.text = String(closestBeacon.proximity)
			rssiLabel?.text = "rssi: " + String(closestBeacon.rssi)
			
			//			uuid
			//			major
			//			minor
			//			rssi
			
		}
	}
	


}

extension CloudDetailViewController: DeviceSelectionDelegate {
	func deviceSelected(_ newDevice: Device) {
		device = newDevice
	}
}
