import UIKit

class HomeViewController: UIViewController {

	var menus:[Menu] = menuData
	var backgroundImageView: UIImageView!
	var leadingConstraint: NSLayoutConstraint!
	var trailingConstraint: NSLayoutConstraint!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		setNavigationBar(title: "Home")
		setMenu()
		setBackgroundImage(image: "estimote01")
		
		let color = UIColor.clear
		//let color = UIColor.blue

		let parent = backgroundImageView!

		// https://www.raywenderlich.com/125718/coding-auto-layout		
		
		let buttonMint: UIButton = setButton(title: "Web", color: color)
		buttonMint.leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
		buttonMint.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
		buttonMint.heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: 0.33).isActive = true
		buttonMint.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: 0.50).isActive = true

		let buttonLemon: UIButton = setButton(title: "Login", color: color)
		buttonLemon.leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
		buttonLemon.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
		buttonLemon.heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: 0.34).isActive = true
		buttonLemon.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: 0.50).isActive = true
		
		let buttonIce: UIButton = setButton(title: "People", color: color)
		buttonIce.leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
		buttonIce.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
		buttonIce.heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: 0.33).isActive = true
		buttonIce.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: 0.50).isActive = true
		
		let buttonBeetroot: UIButton = setButton(title: "Map", color: color)
		buttonBeetroot.rightAnchor.constraint(equalTo: parent.rightAnchor).isActive = true
		buttonBeetroot.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
		buttonBeetroot.heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: 0.33).isActive = true
		buttonBeetroot.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: 0.50).isActive = true
		
		let buttonBlueberry: UIButton = setButton(title: "Beacons", color: color)
		buttonBlueberry.rightAnchor.constraint(equalTo: parent.rightAnchor).isActive = true
		buttonBlueberry.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
		buttonBlueberry.heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: 0.34).isActive = true
		buttonBlueberry.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: 0.50).isActive = true
		
		let buttonCandy: UIButton = setButton(title: "Onboarding", color: color)
		buttonCandy.rightAnchor.constraint(equalTo: parent.rightAnchor).isActive = true
		buttonCandy.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
		buttonCandy.heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: 0.33).isActive = true
		buttonCandy.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: 0.50).isActive = true
	}
	

}


//let buttonBeetroot: UIButton = setButton(title: "Map", color: color)
//NSLayoutConstraint(item:buttonBeetroot,attribute:.left,  relatedBy:.equal,toItem:backgroundImageView,attribute:.right, multiplier:1,constant: -160).isActive=true
//NSLayoutConstraint(item:buttonBeetroot,attribute:.top,   relatedBy:.equal,toItem:backgroundImageView,attribute:.top,multiplier:1,constant:10).isActive=true
//NSLayoutConstraint(item:buttonBeetroot,attribute:.right, relatedBy:.equal,toItem:backgroundImageView,attribute:.right,  multiplier:1,constant: -10).isActive=true
//NSLayoutConstraint(item:buttonBeetroot,attribute:.bottom,relatedBy:.equal,toItem:backgroundImageView,attribute:.top,multiplier:1,constant: 150).isActive=true



