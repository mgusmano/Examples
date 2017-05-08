import UIKit

class GusmanoTableViewCell: UITableViewCell {
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		one()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
//	override var isSelected: Bool
//		{
//		didSet{
//			if (isSelected)
//			{
//				//self.backgroundColor = UIColor.red
//				//self.contentView.backgroundColor = .red
//				self.backgroundColor = .red
//			}
//			else
//			{
//				//self.backgroundColor = UIColor.white
//				self.backgroundColor = .clear
//			}
//		}
//	}
	
	
	func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
		URLSession.shared.dataTask(with: url) {
			(data, response, error) in
			completion(data, response, error)
			}.resume()
	}
	
	func downloadImage(url: URL) {
		//print("Download Started")
		getDataFromUrl(url: url) { (data, response, error)  in
			guard let data = data, error == nil else { return }
			//print(response?.suggestedFilename ?? url.lastPathComponent)
			//print("Download Finished")
			DispatchQueue.main.async() { () -> Void in
				self.picture.image = UIImage(data: data)
			}
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		if let checkedUrl = URL(string: "http://mjg-expressapp.azurewebsites.net" + picturetext) {
			picture.contentMode = .scaleAspectFit
			downloadImage(url: checkedUrl)
		}
	}
	
	let baseview = UIView()
	var picturetext: String = ""
	let picture = UIImageView()
	var fullname = UILabel()
	var title = UILabel()
	var email = UILabel()
	var phone = UILabel()
	var labtime = UILabel()
	
	func one() {
		let fontSize: CGFloat = 16
		//let textColor: UIColor = Layout.textGreen
		let textColor: UIColor = UIColor.white
		
		//Layout.shadow(view: baseview)
		baseview.backgroundColor = UIColor.clear
		Layout.round(view: picture)
		fullname.font = UIFont.systemFont(ofSize: fontSize);fullname.textColor = textColor
		title.font = UIFont.systemFont(ofSize: fontSize);title.textColor = textColor
		email.font = UIFont.systemFont(ofSize: fontSize);email.textColor = textColor
		//phone.font = UIFont.systemFont(ofSize: fontSize);phone.textColor = textColor
	
		baseview.translatesAutoresizingMaskIntoConstraints = false
		picture.translatesAutoresizingMaskIntoConstraints = false
		fullname.translatesAutoresizingMaskIntoConstraints = false
		title.translatesAutoresizingMaskIntoConstraints = false
		email.translatesAutoresizingMaskIntoConstraints = false
//		phone.translatesAutoresizingMaskIntoConstraints = false
		
		contentView.addSubview(baseview)
		contentView.addSubview(picture)
		contentView.addSubview(fullname)
		contentView.addSubview(title)
		contentView.addSubview(email)
//		contentView.addSubview(phone)
		
		NSLayoutConstraint(item:baseview,attribute:.left,  relatedBy:.equal,toItem:contentView,attribute:.left,       multiplier:1,constant: 10).isActive=true
		NSLayoutConstraint(item:baseview,attribute:.top,   relatedBy:.equal,toItem:contentView,attribute:.top,        multiplier:1,constant: 10).isActive=true
		NSLayoutConstraint(item:baseview,attribute:.right, relatedBy:.equal,toItem:contentView,attribute:.right,      multiplier:1,constant:-10).isActive=true
		NSLayoutConstraint(item:baseview,attribute:.bottom,relatedBy:.equal,toItem:contentView,attribute:.bottom,     multiplier:1,constant:-10).isActive=true
		
		NSLayoutConstraint(item:picture, attribute:.left,  relatedBy:.equal,toItem:baseview,attribute: .left,         multiplier:1,constant: 10).isActive=true
		NSLayoutConstraint(item:picture, attribute:.top,   relatedBy:.equal,toItem:baseview,attribute: .top,          multiplier:1,constant: 10).isActive=true
		NSLayoutConstraint(item:picture, attribute:.width, relatedBy:.equal,toItem:nil,     attribute:.notAnAttribute,multiplier:1,constant: 80).isActive=true
		NSLayoutConstraint(item:picture, attribute:.height,relatedBy:.equal,toItem:nil,     attribute:.notAnAttribute,multiplier:1,constant: 80).isActive=true
		
		NSLayoutConstraint(item:fullname,attribute:.left,  relatedBy:.equal,toItem:picture, attribute:.right,         multiplier:1,constant: 10).isActive=true
		NSLayoutConstraint(item:fullname,attribute:.top,   relatedBy:.equal,toItem:baseview,attribute:.top,           multiplier:1,constant: 15).isActive=true
		NSLayoutConstraint(item:fullname,attribute:.width, relatedBy:.equal,toItem:nil,     attribute:.notAnAttribute,multiplier:1,constant:200).isActive=true
		NSLayoutConstraint(item:fullname,attribute:.height,relatedBy:.equal,toItem:nil,     attribute:.notAnAttribute,multiplier:1,constant: 30).isActive=true
		
		NSLayoutConstraint(item:title,   attribute:.left,  relatedBy:.equal,toItem:picture, attribute:.right,         multiplier:1,constant: 10).isActive=true
		NSLayoutConstraint(item:title,   attribute:.top,   relatedBy:.equal,toItem:fullname,attribute:.top,           multiplier:1,constant: 20).isActive=true
		NSLayoutConstraint(item:title,   attribute:.width, relatedBy:.equal,toItem:nil,     attribute:.notAnAttribute,multiplier:1,constant:200).isActive=true
		NSLayoutConstraint(item:title,   attribute:.height,relatedBy:.equal,toItem:nil,     attribute:.notAnAttribute,multiplier:1,constant: 30).isActive=true

		NSLayoutConstraint(item:email,   attribute:.left,  relatedBy:.equal,toItem:picture, attribute:.right,         multiplier:1,constant: 10).isActive=true
		NSLayoutConstraint(item:email,   attribute:.top,   relatedBy:.equal,toItem:title,   attribute:.top,           multiplier:1,constant: 20).isActive=true
		NSLayoutConstraint(item:email,   attribute:.width, relatedBy:.equal,toItem:nil,     attribute:.notAnAttribute,multiplier:1,constant:300).isActive=true
		NSLayoutConstraint(item:email,   attribute:.height,relatedBy:.equal,toItem:nil,     attribute:.notAnAttribute,multiplier:1,constant: 30).isActive=true

		
		
		//picture.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
		//picture.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
		
//		NSLayoutConstraint(item: picture, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
//		NSLayoutConstraint(item: picture, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
		

//		NSLayoutConstraint.activate([widthConstraint, heightConstraint, xConstraint, yConstraint])
		
		//let labelsView = UIStackView(arrangedSubviews: [fullname,labtime]); Layout.stackViewConfig(stackview: labelsView, axis: .vertical)
		
		
		//		let margins = contentView.layoutMarginsGuide
		//		baseView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
		//		baseView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
		//		baseView.heightAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 2.0).isActive = true
		
		
		
		
		
//		var views = Dictionary <String, UIView>()
//		views["picture"] = picture;
//		contentView.addConstraints(Layout.constraint(format: "H:|-20-[picture]", views: views))
//		contentView.addConstraints(Layout.constraint(format: "V:|-20-[picture]", views: views))
		
	}


}


//	//MARK: Properties
//	let colorDictionary = [
//		"Red":UIColor(
//			red: 1.0,
//			green: 0.0,
//			blue: 0.0,
//			alpha: 1.0),
//		"Green":UIColor(
//			red: 0.0,
//			green: 1.0,
//			blue: 0.0, alpha: 1.0),
//		"Blue":UIColor(
//			red: 0.0,
//			green: 0.0,
//			blue: 1.0,
//			alpha: 1.0),
//		]
//
//	//MARK: Instance methods
//	func colorButton(withColor color:UIColor, title:String) -> UIButton {
//		let newButton = UIButton(type: .system)
//		newButton.backgroundColor = color
//		newButton.setTitle(
//			title,
//			for: .normal)
//		newButton.setTitleColor(
//			UIColor.white,
//			for: .normal)
//		return newButton
//	}
//
//	func displayKeyboard() -> [UIButton] {
//		//generate an array of buttons
//		var buttonArray = [UIButton]()
//		for (myKey,myValue) in colorDictionary{
//			buttonArray += [colorButton(
//				withColor: myValue,
//				title: myKey)
//			]
//		}
//		return buttonArray
//	}



