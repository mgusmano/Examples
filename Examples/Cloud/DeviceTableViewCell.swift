import UIKit

class DeviceTableViewCell: UITableViewCell {

	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var identifierLabel: UILabel!
	@IBOutlet weak var colorLabel: UILabel!
	@IBOutlet weak var deviceImageView: UIImageView!
	@IBOutlet weak var uuidLabel: UILabel!
	@IBOutlet weak var minorLabel: UILabel!
	@IBOutlet weak var majorLabel: UILabel!
	
	var device: Device! {
		didSet {
			typeLabel.text = device.type
			identifierLabel.text = device.identifier
			colorLabel.text = device.color
			deviceImageView.image = UIImage(named: device.color)
			uuidLabel.text = device.uuid
			majorLabel.text = "\(device.major)"
			minorLabel.text = "\(device.minor)"
		}
	}
	
}
