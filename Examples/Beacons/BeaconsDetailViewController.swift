import UIKit
import CoreLocation

extension BeaconsDetailViewController: BeaconsSelectionDelegate, CLLocationManagerDelegate {
	func deviceSelected(_ newDevice: Device) {
		device = newDevice
	}
}

class BeaconsDetailViewController: UIViewController {

	let nowlistening = UILabel()
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
	
	var device: Device! {
		didSet (newDevice) {
			self.refreshUI()
		}
	}
	
	func refreshUI() {
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
	
	let locationManager = CLLocationManager()
	var region:CLBeaconRegion?
	//let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, identifier: "Estimotes")
	
//	let colors = [
//		45325: UIColor(red: 231/255, green: 220/255, blue:  48/255, alpha: 1),	//lemon
//		24552: UIColor(red: 142/255, green:  45/255, blue:  89/255, alpha: 1),	//beetroot
//		31138: UIColor(red: 240/255, green: 159/255, blue: 194/255, alpha: 1),	//candy
//		41963: UIColor(red: 119/255, green: 186/255, blue: 227/255, alpha: 1),	//ice
//		22353: UIColor(red:  74/255, green:  56/255, blue: 131/255, alpha: 1),	//bluberry
//		26391: UIColor(red: 175/255, green: 207/255, blue: 171/255, alpha: 1)		//mint
//	]
	
	override func viewWillAppear(_ animated: Bool) {

		var theColor:UIColor = UIColor.white
		switch colorVal
		{
		case "lemon":
			theColor = Layout.lemon
		case "beetroot":
			theColor = Layout.beetroot
		case "candy":
			theColor = Layout.candy
		case "ice":
			theColor = Layout.ice
		case "blueberry":
			theColor = Layout.blueberry
		case "mint":
			theColor = Layout.mint
		default:
			theColor = UIColor.white
		}
		
		view.backgroundColor = theColor
		self.navigationController?.navigationBar.barTintColor = theColor
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
	
	@IBOutlet weak var backgroundImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = true
		self.navigationController?.view.backgroundColor = UIColor.clear
		
		let fontSize: CGFloat = 18;let textColor: UIColor = UIColor.white
		picture.contentMode = .scaleAspectFill
		nowlistening.font = UIFont.systemFont(ofSize: fontSize);nowlistening.textColor = textColor
		detail.font = UIFont.systemFont(ofSize: fontSize);detail.textColor = textColor
		type.font = UIFont.systemFont(ofSize: fontSize);type.textColor = textColor
		identifier.font = UIFont.systemFont(ofSize: fontSize);identifier.textColor = textColor
		color.font = UIFont.systemFont(ofSize: fontSize);color.textColor = textColor
		uuid.font = UIFont.systemFont(ofSize: fontSize);uuid.textColor = textColor
		major.font = UIFont.systemFont(ofSize: fontSize);major.textColor = textColor
		minor.font = UIFont.systemFont(ofSize: fontSize);minor.textColor = textColor
		
		let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
		let blurView = UIVisualEffectView(effect: blurEffect)
		
		backgroundImg.alpha = 0.1
		backgroundImg.addSubview(blurView)

		//view.addSubview(nowlistening)
		view.addSubview(detail)
		view.addSubview(picture)
		view.addSubview(type)
		view.addSubview(identifier)
		view.addSubview(color)
		view.addSubview(uuid)
		view.addSubview(major)
		view.addSubview(minor)
		
		nowlistening.translatesAutoresizingMaskIntoConstraints = false
		detail.translatesAutoresizingMaskIntoConstraints = false
		picture.translatesAutoresizingMaskIntoConstraints = false
		type.translatesAutoresizingMaskIntoConstraints = false
		identifier.translatesAutoresizingMaskIntoConstraints = false
		color.translatesAutoresizingMaskIntoConstraints = false
		uuid.translatesAutoresizingMaskIntoConstraints = false
		major.translatesAutoresizingMaskIntoConstraints = false
		minor.translatesAutoresizingMaskIntoConstraints = false
		blurView.translatesAutoresizingMaskIntoConstraints = false
		backgroundImg.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint(item:backgroundImg,attribute:.left,  relatedBy:.equal,toItem:view,attribute:.left,  multiplier:1,constant:  10).isActive=true
		NSLayoutConstraint(item:backgroundImg,attribute:.top,   relatedBy:.equal,toItem:view,attribute:.top,   multiplier:1,constant:  0).isActive=true
		NSLayoutConstraint(item:backgroundImg,attribute:.right, relatedBy:.equal,toItem:view,attribute:.right, multiplier:1,constant:  0).isActive=true
		NSLayoutConstraint(item:backgroundImg,attribute:.bottom,relatedBy:.equal,toItem:view,attribute:.bottom,multiplier:1,constant:  0).isActive=true
		
		NSLayoutConstraint(item:blurView,attribute:.left,  relatedBy:.equal,toItem:backgroundImg,attribute:.left,  multiplier:1,constant:  10).isActive=true
		NSLayoutConstraint(item:blurView,attribute:.top,   relatedBy:.equal,toItem:backgroundImg,attribute:.top,   multiplier:1,constant:  0).isActive=true
		NSLayoutConstraint(item:blurView,attribute:.right, relatedBy:.equal,toItem:backgroundImg,attribute:.right, multiplier:1,constant:  0).isActive=true
		NSLayoutConstraint(item:blurView,attribute:.bottom,relatedBy:.equal,toItem:backgroundImg,attribute:.bottom,multiplier:1,constant:  0).isActive=true

//		NSLayoutConstraint(item:picture,attribute:.left,  relatedBy:.equal,toItem:backgroundImg,attribute:.left,multiplier:1,constant:   50).isActive=true
		NSLayoutConstraint(item:picture,attribute:.top,   relatedBy:.equal,toItem:topLayoutGuide,attribute:.bottom,multiplier:1,constant: 50).isActive=true
		NSLayoutConstraint(item:picture,attribute:.width, relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 100).isActive=true
		NSLayoutConstraint(item:picture,attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 100).isActive=true
		picture.centerXAnchor.constraint(equalTo: backgroundImg.centerXAnchor).isActive = true
		
		//NSLayoutConstraint(item:detail,attribute:.left,  relatedBy:.equal,toItem:picture,attribute:.right,multiplier:1,constant:  10).isActive=true
		NSLayoutConstraint(item:detail,attribute:.top,   relatedBy:.equal,toItem:picture,attribute:.bottom,multiplier:1,constant: 60).isActive=true
		NSLayoutConstraint(item:detail,attribute:.width, relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 80).isActive=true
		NSLayoutConstraint(item:detail,attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 30).isActive=true
		detail.centerXAnchor.constraint(equalTo: backgroundImg.centerXAnchor).isActive = true
		
		NSLayoutConstraint(item:color,attribute:.left,  relatedBy:.equal,toItem:backgroundImg,attribute:.left,multiplier:1,constant:   10).isActive=true
		NSLayoutConstraint(item:color,attribute:.top,   relatedBy:.equal,toItem:detail,attribute:.bottom,multiplier:1,constant: 10).isActive=true
		NSLayoutConstraint(item:color,attribute:.width, relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 350).isActive=true
		NSLayoutConstraint(item:color,attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 30).isActive=true

		NSLayoutConstraint(item:identifier,attribute:.left,  relatedBy:.equal,toItem:backgroundImg,attribute:.left,multiplier:1,constant:   10).isActive=true
		NSLayoutConstraint(item:identifier,attribute:.top,   relatedBy:.equal,toItem:color,attribute:.bottom,multiplier:1,constant: 0).isActive=true
		NSLayoutConstraint(item:identifier,attribute:.width, relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 350).isActive=true
		NSLayoutConstraint(item:identifier,attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 30).isActive=true

		NSLayoutConstraint(item:type,attribute:.left,  relatedBy:.equal,toItem:backgroundImg,attribute:.left,multiplier:1,constant:   10).isActive=true
		NSLayoutConstraint(item:type,attribute:.top,   relatedBy:.equal,toItem:identifier,attribute:.bottom,multiplier:1,constant: 0).isActive=true
		NSLayoutConstraint(item:type,attribute:.width, relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 350).isActive=true
		NSLayoutConstraint(item:type,attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 30).isActive=true

		NSLayoutConstraint(item:uuid,attribute:.left,  relatedBy:.equal,toItem:backgroundImg,attribute:.left,multiplier:1,constant:  10).isActive=true
		NSLayoutConstraint(item:uuid,attribute:.top,   relatedBy:.equal,toItem:type,attribute:.bottom,multiplier:1,constant: 0).isActive=true
		NSLayoutConstraint(item:uuid,attribute:.width, relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 450).isActive=true
		NSLayoutConstraint(item:uuid,attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 30).isActive=true
		
		NSLayoutConstraint(item:major,attribute:.left,  relatedBy:.equal,toItem:backgroundImg,attribute:.left,multiplier:1,constant:  10).isActive=true
		NSLayoutConstraint(item:major,attribute:.top,   relatedBy:.equal,toItem:uuid,attribute:.bottom,multiplier:1,constant: 0).isActive=true
		NSLayoutConstraint(item:major,attribute:.width, relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 350).isActive=true
		NSLayoutConstraint(item:major,attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 30).isActive=true

		NSLayoutConstraint(item:minor,attribute:.left,  relatedBy:.equal,toItem:backgroundImg,attribute:.left,multiplier:1,constant:  10).isActive=true
		NSLayoutConstraint(item:minor,attribute:.top,   relatedBy:.equal,toItem:major,attribute:.bottom,multiplier:1,constant: 0).isActive=true
		NSLayoutConstraint(item:minor,attribute:.width, relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 450).isActive=true
		NSLayoutConstraint(item:minor,attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 30).isActive=true
		
//		NSLayoutConstraint(item:nowlistening,attribute:.left,  relatedBy:.equal,toItem:backgroundImg,attribute:.left,multiplier:1,constant:  0).isActive=true
//		NSLayoutConstraint(item:nowlistening,attribute:.top,   relatedBy:.equal,toItem:minor,attribute:.bottom,multiplier:1,constant: 0).isActive=true
//		NSLayoutConstraint(item:nowlistening,attribute:.width, relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 450).isActive=true
//		NSLayoutConstraint(item:nowlistening,attribute:.height,relatedBy:.equal,toItem:nil,attribute:.notAnAttribute,multiplier:0,constant: 30).isActive=true

		picture.layer.shadowOpacity = 1
		picture.layer.shadowRadius = 15
		
		
//		let ovalRect = CGRect(x:0.0, y:100 + 40, width:100, height:15)
//		let path04 = UIBezierPath(ovalIn: ovalRect)
//		picture.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
//		picture.layer.shadowOffset = CGSize(width:0.0, height:0.0)
//		picture.layer.shadowOpacity = 1.0
//		picture.layer.shadowRadius = 3.0
//		picture.layer.shadowPath = path04.cgPath
		
		locationManager.delegate = self
		if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.authorizedWhenInUse) {
			locationManager.requestWhenInUseAuthorization()
		}
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

