import UIKit

class BeaconsTableViewCell: UITableViewCell {

	let baseview = UIView()
	var picturetext: String = ""
	var picture = UIImageView()
	var type = UILabel()
	var identifier = UILabel()
	var uuid = UILabel()
	var major = UILabel()
	var minor = UILabel()
	var color = UILabel()
//	var email = UILabel()
	//var phone = UILabel()
	//var labtime = UILabel()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		backgroundColor = UIColor.clear
		selectionStyle = .none
		
		let fontSize: CGFloat = 24;let textColor: UIColor = UIColor.white
		
		picture.contentMode = .scaleAspectFill
		
		
		Layout.shadow(view: baseview)
		baseview.backgroundColor = UIColor.clear
		//Layout.round(view: picture)
		type.font = UIFont.systemFont(ofSize: fontSize);type.textColor = textColor
		identifier.font = UIFont.systemFont(ofSize: fontSize-7);identifier.textColor = textColor
		uuid.font = UIFont.systemFont(ofSize: fontSize);uuid.textColor = textColor
		major.font = UIFont.systemFont(ofSize: fontSize);major.textColor = textColor
		minor.font = UIFont.systemFont(ofSize: fontSize);minor.textColor = textColor
		color.font = UIFont.systemFont(ofSize: fontSize);color.textColor = textColor
		
		baseview.translatesAutoresizingMaskIntoConstraints = false
		picture.translatesAutoresizingMaskIntoConstraints = false
		type.translatesAutoresizingMaskIntoConstraints = false
		identifier.translatesAutoresizingMaskIntoConstraints = false
		uuid.translatesAutoresizingMaskIntoConstraints = false
		major.translatesAutoresizingMaskIntoConstraints = false
		minor.translatesAutoresizingMaskIntoConstraints = false
		color.translatesAutoresizingMaskIntoConstraints = false
		
		contentView.addSubview(baseview)
		contentView.addSubview(picture)
		contentView.addSubview(type)
		contentView.addSubview(identifier)
		//contentView.addSubview(uuid)
		//contentView.addSubview(major)
		//contentView.addSubview(minor)
		contentView.addSubview(color)
		
		NSLayoutConstraint(item:baseview,attribute:.left,  relatedBy:.equal,toItem:contentView,attribute:.left,       multiplier:1,constant: -1).isActive=true
		NSLayoutConstraint(item:baseview,attribute:.top,   relatedBy:.equal,toItem:contentView,attribute:.top,        multiplier:1,constant:  0).isActive=true
		NSLayoutConstraint(item:baseview,attribute:.right, relatedBy:.equal,toItem:contentView,attribute:.right,      multiplier:1,constant:  1).isActive=true
		NSLayoutConstraint(item:baseview,attribute:.bottom,relatedBy:.equal,toItem:contentView,attribute:.bottom,     multiplier:1,constant:  0).isActive=true
		
		NSLayoutConstraint(item:picture, attribute:.left,  relatedBy:.equal,toItem:baseview,   attribute: .left,         multiplier:1,constant: 20).isActive=true
		NSLayoutConstraint(item:picture, attribute:.top,   relatedBy:.equal,toItem:baseview,   attribute: .top,          multiplier:1,constant: 30).isActive=true
		NSLayoutConstraint(item:picture, attribute:.width, relatedBy:.equal,toItem:nil,        attribute:.notAnAttribute,multiplier:1,constant: 40).isActive=true
		NSLayoutConstraint(item:picture, attribute:.height,relatedBy:.equal,toItem:nil,        attribute:.notAnAttribute,multiplier:1,constant: 40).isActive=true
		
		NSLayoutConstraint(item:color,attribute:.left,  relatedBy:.equal,toItem:picture,       attribute:.right,         multiplier:1,constant: 15).isActive=true
		NSLayoutConstraint(item:color,attribute:.top,   relatedBy:.equal,toItem:baseview,      attribute:.top,           multiplier:1,constant: 18).isActive=true
		NSLayoutConstraint(item:color,attribute:.width, relatedBy:.equal,toItem:nil,           attribute:.notAnAttribute,multiplier:1,constant:200).isActive=true
		NSLayoutConstraint(item:color,attribute:.height,relatedBy:.equal,toItem:nil,           attribute:.notAnAttribute,multiplier:1,constant: 30).isActive=true
		
		NSLayoutConstraint(item:type,   attribute:.left,  relatedBy:.equal,toItem:picture, attribute:.right,         multiplier:1,constant: 15).isActive=true
		NSLayoutConstraint(item:type,   attribute:.top,   relatedBy:.equal,toItem:color,   attribute:.top,           multiplier:1,constant: 30).isActive=true
		NSLayoutConstraint(item:type,   attribute:.width, relatedBy:.equal,toItem:nil,     attribute:.notAnAttribute,multiplier:1,constant:200).isActive=true
		NSLayoutConstraint(item:type,   attribute:.height,relatedBy:.equal,toItem:nil,     attribute:.notAnAttribute,multiplier:1,constant: 30).isActive=true
		
		NSLayoutConstraint(item:identifier,   attribute:.left,  relatedBy:.equal,toItem:baseview, attribute:.left,         multiplier:1,constant: 15).isActive=true
		NSLayoutConstraint(item:identifier,   attribute:.top,   relatedBy:.equal,toItem:picture,    attribute:.bottom,           multiplier:1,constant: 20).isActive=true
		NSLayoutConstraint(item:identifier,   attribute:.width, relatedBy:.equal,toItem:nil,     attribute:.notAnAttribute,multiplier:1,constant:350).isActive=true
		NSLayoutConstraint(item:identifier,   attribute:.height,relatedBy:.equal,toItem:nil,     attribute:.notAnAttribute,multiplier:1,constant: 30).isActive=true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
//	func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
//		URLSession.shared.dataTask(with: url) {
//			(data, response, error) in
//			completion(data, response, error)
//			}.resume()
//	}
//	
//	func downloadImage(url: URL) {
//		//print("Download Started")
//		getDataFromUrl(url: url) { (data, response, error)  in
//			guard let data = data, error == nil else { return }
//			//print(response?.suggestedFilename ?? url.lastPathComponent)
//			//print("Download Finished")
//			DispatchQueue.main.async() { () -> Void in
//				self.picture.image = UIImage(data: data)
//			}
//		}
//	}
//	
	override func layoutSubviews() {
		super.layoutSubviews()
		picture.image = UIImage(named: picturetext)
		
		
		//image.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
		
		//let s = UIImage(named: picturetext)
		//picture.image = imageWithImage(image: s!,scaledToSize: CGSize(width:25, height:25))
		
		//var image = imageWithImage
		
		
		//picture.sizeThatFits(CGSize(width: 100, height: 100))

//		if let checkedUrl = URL(string: "http://mjg-expressapp.azurewebsites.net" + picturetext) {
//			picture.contentMode = .scaleAspectFit
//			downloadImage(url: checkedUrl)
//		}
	}
	
	func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
		UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
		image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
		let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return newImage
	}
}
