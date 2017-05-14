import UIKit

// https://medium.com/swift-programming/swift-selector-syntax-sugar-81c8a8b10df3
fileprivate extension Selector {
	static let buttonTapped = #selector(HomeViewController.buttonTapped(_ :))
}

extension HomeViewController {

	func toggleSideMenu(_ sender: Any) {
		let menuWidth: CGFloat = 200
		if (leadingConstraint.constant != 0) {
			leadingConstraint.constant = 0
			trailingConstraint.constant = 0
		}
		else {
			leadingConstraint.constant = menuWidth
			trailingConstraint.constant = menuWidth
		}
		UIView.animate(withDuration: 0.2,animations: { self.view.layoutIfNeeded() })
	}
	
	func setNavigationBar(title: String) {
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = false
		//self.navigationController?.view.backgroundColor = UIColor.clear
		//self.navigationController?.view.backgroundColor = UIColor.black
		self.navigationController?.navigationBar.barTintColor = UIColor.black
		self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
		self.title = title
		let button = UIButton.init(type: .custom)
		button.setImage(UIImage(named: "Burger"), for: UIControlState.normal)
		button.addTarget(self, action: #selector(HomeViewController.toggleSideMenu), for: UIControlEvents.touchUpInside)
		button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
		let barButton = UIBarButtonItem(customView: button)
		button.tintColor = UIColor.white
		self.navigationItem.leftBarButtonItem = barButton
	}
	
	func setMenu() {
		let menuTableView = UITableView()
		menuTableView.delegate = self
		menuTableView.dataSource = self
		menuTableView.separatorStyle = .none
		menuTableView.register(HomeMenuTableViewCell.classForCoder(), forCellReuseIdentifier: "HomeMenu")
		menuTableView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(menuTableView)
		
		NSLayoutConstraint(item:menuTableView,attribute:.left,  relatedBy:.equal,toItem:view,attribute:.left,  multiplier:1,constant: 0).isActive=true
		NSLayoutConstraint(item:menuTableView,attribute:.top,   relatedBy:.equal,toItem:view,attribute:.top,   multiplier:1,constant: 0).isActive=true
		NSLayoutConstraint(item:menuTableView,attribute:.right, relatedBy:.equal,toItem:view,attribute:.left, multiplier:1,constant:200).isActive=true
		NSLayoutConstraint(item:menuTableView,attribute:.bottom,relatedBy:.equal,toItem:view,attribute:.bottom,multiplier:1,constant: 0).isActive=true
	}
	
	func buttonTapped(_ sender: UIButton!) {
		let s: String = sender.title(for: .normal)!
		Util.nav(s)
	}
	
	func setButton(title: String, color: UIColor) -> UIButton {
		let button = UIButton()
		button.backgroundColor = color
		button.setTitle(title, for: .normal)
		button.addTarget(self, action: .buttonTapped, for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(button)
		return button
	}
	
	func setBackgroundImage(image: String) {
		let image = UIImage(named: image)!
		self.backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		//self.backgroundImageView.contentMode = .scaleAspectFill
		self.backgroundImageView.image = image
		self.view.addSubview(backgroundImageView)
		backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
		backgroundImageView.layer.shadowOpacity = 1
		backgroundImageView.layer.shadowRadius = 15
		
		leadingConstraint=NSLayoutConstraint(item:backgroundImageView,attribute:.left,relatedBy:.equal,toItem:view,attribute:.left,multiplier:1,constant:0)
		NSLayoutConstraint(item:backgroundImageView,attribute:.top,relatedBy:.equal,toItem:view,attribute:.top,multiplier:1,constant:0).isActive=true
		trailingConstraint=NSLayoutConstraint(item:backgroundImageView,attribute:.right,relatedBy:.equal,toItem:view,attribute:.right,multiplier:1,constant:0)
		NSLayoutConstraint(item:backgroundImageView,attribute:.bottom,relatedBy:.equal,toItem:view,attribute:.bottom,multiplier:1,constant:0).isActive=true
		
		trailingConstraint.isActive = true
		leadingConstraint.isActive = true
	}
	
	
}
