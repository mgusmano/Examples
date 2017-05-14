import Foundation
import UIKit


extension UINavigationBar {
	
	func transparentNavigationBar() {
		self.setBackgroundImage(UIImage(), for: .default)
		self.shadowImage = UIImage()
		self.isTranslucent = true
	}
}

//http://uicolor.xyz/#/hex-to-ui

class Layout: NSObject {
	
	static var textGreen: UIColor = UIColor(red:0.22, green:0.73, blue:0.75, alpha:1.0)
	static var burntOrange:UIColor = UIColor(red: 255/255, green: 204/255, blue: 102/255, alpha: 1)
	
	static var mint:UIColor = UIColor(red: 145/255, green: 187/255, blue: 163/255, alpha: 1)
	static var beetroot:UIColor = UIColor(red: 84/255, green: 0/255, blue: 61/255, alpha: 1)
	static var blueberry:UIColor = UIColor(red: 44/255, green: 38/255, blue: 86/255, alpha: 1)
	static var candy:UIColor = UIColor(red: 219/255, green: 121/255, blue: 165/255, alpha: 1)
	static var ice:UIColor = UIColor(red: 90/255, green: 174/255, blue: 207/255, alpha: 1)
	static var lemon:UIColor = UIColor(red: 196/255, green: 191/255, blue: 0/255, alpha: 1)
	
	static func getColor(color: String) -> UIColor {
		var theColor:UIColor = UIColor.white
		switch color
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
		return theColor
	}
	
	static let staticProperty = 0
	
	static func round(view: UIView) {
		view.layer.borderWidth = 0.5
		view.layer.borderColor=UIColor.white.cgColor
		view.layer.backgroundColor=UIColor.clear.cgColor
		view.layer.cornerRadius=40
		//view.layer.cornerRadius=view.frame.size.width / 2
		view.clipsToBounds = true;
		//view.layer.masksToBounds = true
	}
	
	
	static func shadow(view: UIView) {
		
//		view.layer.cornerRadius = 3
//		view.layer.shadowColor = UIColor.black.cgColor //UIColor(red:0/255.0,green:0/255.0,blue:0/255.0,alpha: 1.0).cgColor
//		view.layer.shadowOffset = CGSize(width: 0, height: 1.75)
//		view.layer.shadowRadius = 2.7
//		view.layer.shadowOpacity = 0.45
//		view.backgroundColor = UIColor.yellow
//		view.layer.shouldRasterize = true
		
		
		//view.backgroundColor = UIColor(red:0.90, green:0.94, blue:0.95, alpha:1.0) //light green
		
		view.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0) //light light gray
		
		view.layer.borderWidth = 0.5
		view.layer.borderColor = UIColor.lightGray.cgColor
		view.layer.shadowColor = UIColor.lightGray.cgColor
		view.layer.shadowOpacity = 0.8
		view.layer.shadowRadius = 5.0
		view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
		view.layer.masksToBounds = false;
	}
	
	static func constraint(format: String, views: [String:Any]) -> [NSLayoutConstraint] {
		return NSLayoutConstraint.constraints(
			withVisualFormat: format,
			options: NSLayoutFormatOptions(rawValue:0),
			metrics: nil,
			views: views)
	}
	
	static func stackViewConfig(stackview: UIStackView, axis: UILayoutConstraintAxis) {
		stackview.layer.borderWidth = 5
		stackview.axis = axis
		stackview.distribution = .fillEqually
		stackview.alignment = .fill
		stackview.spacing = 0
		stackview.translatesAutoresizingMaskIntoConstraints = false
	}
	
}
