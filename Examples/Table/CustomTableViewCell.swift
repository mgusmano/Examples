import UIKit

class CustomTableViewCell: UITableViewCell {

//	let imgUser = UIImageView()
//	let labUerName = UILabel()
//	let labMessage = UILabel()
//	let labTime = UILabel()
//	let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
	
	var typeLabel: UILabel!
	
	@IBOutlet weak var identifierLabel: UILabel!
	var colorLabel: UILabel!
	@IBOutlet weak var deviceImageView: UIImageView!
	@IBOutlet weak var uuidLabel: UILabel!
	@IBOutlet weak var minorLabel: UILabel!
	@IBOutlet weak var majorLabel: UILabel!
	
//	let typeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
//	let colorLabel = UILabel(frame: CGRect(x: 0, y: 10, width: 100, height: 10))
	
	var device: Device! {
		didSet {
			typeLabel.text = device.type
//			identifierLabel.text = device.identifier
			colorLabel.text = device.color
//			deviceImageView.image = UIImage(named: device.color)
//			uuidLabel.text = device.uuid
//			majorLabel.text = "\(device.major)"
//			minorLabel.text = "\(device.minor)"
		}
	}

	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	
		let gap : CGFloat = 10
		let labelHeight: CGFloat = 30
		let labelWidth: CGFloat = 150
		let lineGap : CGFloat = 5
		let label2Y : CGFloat = gap + labelHeight + lineGap
//		let imageSize : CGFloat = 30
		
		typeLabel = UILabel()
		typeLabel.frame = CGRect(x:gap, y:gap, width:labelWidth, height:labelHeight)
		typeLabel.textColor = UIColor.black
		contentView.addSubview(typeLabel)
		
		colorLabel = UILabel()
		colorLabel.frame = CGRect(x:gap, y:label2Y, width:labelWidth, height:labelHeight)
		colorLabel.textColor = UIColor.black
		contentView.addSubview(colorLabel)
		
		
		//colorLabel = UILabel()
		
//		typeLabel.translatesAutoresizingMaskIntoConstraints = false
//		colorLabel.translatesAutoresizingMaskIntoConstraints = false

		
		
		//
//		typeLabel.backgroundColor = UIColor.blue
//		colorLabel.backgroundColor = UIColor.red
		
		//contentView.addSubview(typeLabel)
		//contentView.addSubview(colorLabel)
		
//		var viewsDict = Dictionary <String, UIView>()
//		viewsDict["typeLabel"] = typeLabel;
//		viewsDict["colorLabel"] = colorLabel;
//		
//		contentView.addConstraints(NSLayoutConstraint.constraints(
//			withVisualFormat: "V:|-[typeLabel]-[colorLabel]-|",
//			options: [],
//			metrics: nil,
//			views: viewsDict
//		));
//		contentView.addConstraints(NSLayoutConstraint.constraints(
//			withVisualFormat: "H:|-[typeLabel]-|",
//			options: [],
//			metrics: nil,
//			views: viewsDict
//		));
//		
//		contentView.addConstraints(NSLayoutConstraint.constraints(
//			withVisualFormat: "H:|-[colorLabel]-|",
//			options: [],
//			metrics: nil,
//			views: viewsDict
//		));
	
	}

	
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

		typeLabel.backgroundColor = UIColor.blue
		contentView.addSubview(typeLabel)
		
		
//		contentView.addSubview(identifierLabel)
//		contentView.addSubview(colorLabel)
//		contentView.addSubview(deviceImageView)
//		contentView.addSubview(uuidLabel)
//		contentView.addSubview(minorLabel)
//		contentView.addSubview(majorLabel)
		
		
//		contentView.addSubview(button)
//			contentView.addSubview(imgUser)
//			contentView.addSubview(labUerName)
//			contentView.addSubview(labMessage)
//			contentView.addSubview(labTime)
		
			
////			view.backgroundColor = UIColor.blue
//			
//			let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
//			label.center = CGPoint(x: 160, y: 285)
//			label.textAlignment = .center
//			label.text = "I'am a test label"
////			self.view.addSubview(label)
//			
//			
//			let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
//			button.backgroundColor = .green
//			button.setTitle("Test Button", for: .normal)
//			button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//			
//			self.view.addSubview(button)
////
			
			
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
