import UIKit

class PeopleDetailViewController: UIViewController {

	let firstname = UILabel(frame: CGRect(x: 0, y: 210, width: 200, height: 21))
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.addSubview(firstname)
		
		
		
    }
	
	var device: Person! {
		didSet (newDevice) {
			self.refreshUI()
		}
	}
	
	func refreshUI() {
		firstname.text = device.firstname
//		typeLabel?.text = device.type
//		identifierLabel?.text = device.identifier
//		iconImageView?.image = device.iconImage()
//		uuidLabel?.text = device.uuid
//		majorLabel?.text = "\(device.major)"
//		minorLabel?.text = "\(device.minor)"
	}
	
	
}

extension PeopleDetailViewController: PeopleSelectionDelegate {
	func deviceSelected(_ newDevice: Person) {
		device = newDevice
	}
}
