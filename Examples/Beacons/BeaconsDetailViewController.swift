import UIKit
import CoreLocation

extension BeaconsDetailViewController: BeaconsSelectionDelegate, CLLocationManagerDelegate {
	func deviceSelected(_ newDevice: Device) {
		//device = newDevice
		self.refreshUI(device: newDevice)
	}
	
	func refreshUI(device: Device) {
		type.text = device.type
		identifier.text = device.identifier
		color.text = device.color
		colorVal = device.color
		uuid.text = device.uuid
		major.text = String(device.major)
		minor.text = String(device.minor)
		picture.image = UIImage(named: device.color)
		uuidVal = device.uuid
		majorVal = UInt16(device.major)
		minorVal = UInt16(device.minor)
	}
}

class BeaconsDetailViewController: UIViewController {

	//let nowlistening = UILabel()
	let detail = UILabel()
	var picture = UIImageView()
	let type = UILabel()
	let identifier = UILabel()
	let color = UILabel()
	let uuid = UILabel()
	let major = UILabel()
	let minor = UILabel()
	var colorVal = ""
	var uuidVal:String = ""
	var majorVal:UInt16 = 0
	var minorVal:UInt16 = 0
	
//	var device: Device! {
//		didSet (newDevice) {
//			self.refreshUI()
//		}
//	}

	let locationManager = CLLocationManager()
	var region:CLBeaconRegion?
	
	override func viewWillAppear(_ animated: Bool) {
		let theColor:UIColor = Layout.getColor(color: colorVal)
		view.backgroundColor = theColor
		self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
		self.title = colorVal
	}
	
	override func viewDidAppear(_ animated: Bool) {
		region = CLBeaconRegion(proximityUUID:UUID(uuidString: uuidVal)!,major:majorVal,minor:minorVal,identifier:"Estimotes")
		locationManager.startRangingBeacons(in: region!)
		//nowlistening.text = "now: " + uuidVal
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		locationManager.stopRangingBeacons(in: region!)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		locationManager.delegate = self
		if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse) {
			locationManager.requestWhenInUseAuthorization()
		}
		
		//setNavigationBar(title: "Home")
		
		let fontSize: CGFloat = 18;let textColor: UIColor = UIColor.white
		
		picture.contentMode = .scaleAspectFill
		picture.layer.shadowOpacity = 1
		picture.layer.shadowRadius = 15
		detail.font = UIFont.systemFont(ofSize: fontSize);detail.textColor = textColor
		type.font = UIFont.systemFont(ofSize: fontSize);type.textColor = textColor
		identifier.font = UIFont.systemFont(ofSize: fontSize);identifier.textColor = textColor
		color.font = UIFont.systemFont(ofSize: fontSize);color.textColor = textColor
		uuid.font = UIFont.systemFont(ofSize: fontSize);uuid.textColor = textColor
		major.font = UIFont.systemFont(ofSize: fontSize);major.textColor = textColor
		minor.font = UIFont.systemFont(ofSize: fontSize);minor.textColor = textColor
		
		view.addSubview(detail)
		view.addSubview(picture)
		view.addSubview(type)
		view.addSubview(identifier)
		view.addSubview(color)
		view.addSubview(uuid)
		view.addSubview(major)
		view.addSubview(minor)
		
		picture.translatesAutoresizingMaskIntoConstraints = false
		detail.translatesAutoresizingMaskIntoConstraints = false
		type.translatesAutoresizingMaskIntoConstraints = false
		identifier.translatesAutoresizingMaskIntoConstraints = false
		color.translatesAutoresizingMaskIntoConstraints = false
		uuid.translatesAutoresizingMaskIntoConstraints = false
		major.translatesAutoresizingMaskIntoConstraints = false
		minor.translatesAutoresizingMaskIntoConstraints = false

//		NSLayoutConstraint(item:picture,attribute:.left,  relatedBy:.equal,toItem:backgroundImg,attribute:.left,multiplier:1,constant:   50).isActive=true
		NSLayoutConstraint(item:picture,attribute:.top,   relatedBy:.equal,toItem:topLayoutGuide,attribute:.bottom,multiplier:1,constant: 50).isActive=true
		NSLayoutConstraint(item:picture,attribute:.width, relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 100).isActive=true
		NSLayoutConstraint(item:picture,attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 100).isActive=true
		picture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		
		//NSLayoutConstraint(item:detail,attribute:.left,  relatedBy:.equal,toItem:picture,attribute:.right,multiplier:1,constant:  10).isActive=true
		NSLayoutConstraint(item:detail,attribute:.top,   relatedBy:.equal,toItem:picture,attribute:.bottom,multiplier:1,constant: 60).isActive=true
		NSLayoutConstraint(item:detail,attribute:.width, relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 80).isActive=true
		NSLayoutConstraint(item:detail,attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 30).isActive=true
		detail.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		
		NSLayoutConstraint(item:color,attribute:.left,  relatedBy:.equal,toItem:view,attribute:.left,multiplier:1,constant:   10).isActive=true
		NSLayoutConstraint(item:color,attribute:.top,   relatedBy:.equal,toItem:detail,attribute:.bottom,multiplier:1,constant: 10).isActive=true
		NSLayoutConstraint(item:color,attribute:.width, relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 350).isActive=true
		NSLayoutConstraint(item:color,attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 30).isActive=true

		NSLayoutConstraint(item:identifier,attribute:.left,  relatedBy:.equal,toItem:view,attribute:.left,multiplier:1,constant:   10).isActive=true
		NSLayoutConstraint(item:identifier,attribute:.top,   relatedBy:.equal,toItem:color,attribute:.bottom,multiplier:1,constant: 0).isActive=true
		NSLayoutConstraint(item:identifier,attribute:.width, relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 350).isActive=true
		NSLayoutConstraint(item:identifier,attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 30).isActive=true

		NSLayoutConstraint(item:type,attribute:.left,  relatedBy:.equal,toItem:view,attribute:.left,multiplier:1,constant:   10).isActive=true
		NSLayoutConstraint(item:type,attribute:.top,   relatedBy:.equal,toItem:identifier,attribute:.bottom,multiplier:1,constant: 0).isActive=true
		NSLayoutConstraint(item:type,attribute:.width, relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 350).isActive=true
		NSLayoutConstraint(item:type,attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 30).isActive=true

		NSLayoutConstraint(item:uuid,attribute:.left,  relatedBy:.equal,toItem:view,attribute:.left,multiplier:1,constant:  10).isActive=true
		NSLayoutConstraint(item:uuid,attribute:.top,   relatedBy:.equal,toItem:type,attribute:.bottom,multiplier:1,constant: 0).isActive=true
		NSLayoutConstraint(item:uuid,attribute:.width, relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 450).isActive=true
		NSLayoutConstraint(item:uuid,attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 30).isActive=true
		
		NSLayoutConstraint(item:major,attribute:.left,  relatedBy:.equal,toItem:view,attribute:.left,multiplier:1,constant:  10).isActive=true
		NSLayoutConstraint(item:major,attribute:.top,   relatedBy:.equal,toItem:uuid,attribute:.bottom,multiplier:1,constant: 0).isActive=true
		NSLayoutConstraint(item:major,attribute:.width, relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 350).isActive=true
		NSLayoutConstraint(item:major,attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 30).isActive=true

		NSLayoutConstraint(item:minor,attribute:.left,  relatedBy:.equal,toItem:view,attribute:.left,multiplier:1,constant:  10).isActive=true
		NSLayoutConstraint(item:minor,attribute:.top,   relatedBy:.equal,toItem:major,attribute:.bottom,multiplier:1,constant: 0).isActive=true
		NSLayoutConstraint(item:minor,attribute:.width, relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 450).isActive=true
		NSLayoutConstraint(item:minor,attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 30).isActive=true
	}
	
	func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
		//print(beacons.count)
		let knownBeacons = beacons.filter{ $0.proximity != CLProximity.unknown }
		if (knownBeacons.count > 0) {
			let closestBeacon = knownBeacons[0] as CLBeacon
			//			print(closestBeacon.rssi)
//			self.view.backgroundColor = self.colors[closestBeacon.minor.intValue]
			print(closestBeacon)
			//detail.text = String(closestBeacon.proximity)
			detail.text = "rssi: " + String(closestBeacon.rssi)
		}
	}
}

