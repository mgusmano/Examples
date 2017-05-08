import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

	func go(to: String) {
		leadingConstraint.constant = 0
		trailingConstraint.constant = 0
		menuShowing = false
		Util.nav(to)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return menus.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: HomeMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeMenu", for: indexPath) as! HomeMenuTableViewCell
		cell.textLabel?.text = menus[indexPath.row].title
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedItem = menus[indexPath.row].storyboard
		go(to: selectedItem)
	}
}

class HomeViewController: UIViewController {

	var menus:[Menu] = menuData

	var menuShowing = false
	var menuWidth: CGFloat = 200
	func toggleSideMenu(_ sender: Any) {
		if (menuShowing) {
			leadingConstraint.constant = 0
			trailingConstraint.constant = 0
		}
		else {
			leadingConstraint.constant = menuWidth
			trailingConstraint.constant = menuWidth
		}
		UIView.animate(withDuration: 0.2,animations: { self.view.layoutIfNeeded() })
		menuShowing = !menuShowing
	}
	
	//func goToMenu() { Util.nav("Menu") }
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
	
	var backgroundImageView: UIImageView!
	var leadingConstraint: NSLayoutConstraint!
	var trailingConstraint: NSLayoutConstraint!
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

	var menuTableView: UITableView!
	func setMenu() {
		menuTableView = UITableView()
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

	var buttonIce: UIButton!
	func buttonIceAction(sender: UIButton!) { Util.nav("People") }
	func setIceButton(color: UIColor) {
		buttonIce = UIButton()
		buttonIce.backgroundColor = color
		buttonIce.setTitle("People", for: .normal)
		buttonIce.addTarget(self, action: #selector(buttonIceAction), for: .touchUpInside)
		buttonIce.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(buttonIce)
		
		NSLayoutConstraint(item:buttonIce,attribute:.left,  relatedBy:.equal,toItem:backgroundImageView,attribute:.left,  multiplier:1,constant:  50).isActive=true
		NSLayoutConstraint(item:buttonIce,attribute:.top,   relatedBy:.equal,toItem:backgroundImageView,attribute:.bottom,multiplier:1,constant:-150).isActive=true
		NSLayoutConstraint(item:buttonIce,attribute:.right, relatedBy:.equal,toItem:backgroundImageView,attribute:.left,  multiplier:1,constant: 200).isActive=true
		NSLayoutConstraint(item:buttonIce,attribute:.bottom,relatedBy:.equal,toItem:backgroundImageView,attribute:.bottom,multiplier:1,constant: -10).isActive=true
	}
	
	var buttonLemon: UIButton!
	func buttonLemonAction(sender: UIButton!) { Util.nav("Login") }
	func setLemonButton(color: UIColor) {
		buttonLemon = UIButton()
		buttonLemon.backgroundColor = color
		buttonLemon.setTitle("Hotel California", for: .normal)
		buttonLemon.addTarget(self, action: #selector(buttonLemonAction), for: .touchUpInside)
		buttonLemon.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(buttonLemon)
		
		NSLayoutConstraint(item:buttonLemon,attribute:.left,  relatedBy:.equal,toItem:backgroundImageView,attribute:.left,  multiplier:1,constant:  50).isActive=true
		NSLayoutConstraint(item:buttonLemon,attribute:.top,   relatedBy:.equal,toItem:backgroundImageView,attribute:.bottom,multiplier:1,constant:-375).isActive=true
		NSLayoutConstraint(item:buttonLemon,attribute:.right, relatedBy:.equal,toItem:backgroundImageView,attribute:.left,  multiplier:1,constant: 200).isActive=true
		NSLayoutConstraint(item:buttonLemon,attribute:.bottom,relatedBy:.equal,toItem:backgroundImageView,attribute:.bottom,multiplier:1,constant:-225).isActive=true
	}
	
	var buttonMint: UIButton!
	func buttonMintAction(sender: UIButton!) { Util.nav("Web") }
	func setMintButton(color: UIColor) {
		buttonMint = UIButton()
		buttonMint.backgroundColor = color
		buttonMint.setTitle("Web", for: .normal)
		buttonMint.addTarget(self, action: #selector(buttonMintAction), for: .touchUpInside)
		buttonMint.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(buttonMint)
		
		NSLayoutConstraint(item:buttonMint,attribute:.left,  relatedBy:.equal,toItem:backgroundImageView,attribute:.left,  multiplier:1,constant:  50).isActive=true
		NSLayoutConstraint(item:buttonMint,attribute:.top,   relatedBy:.equal,toItem:backgroundImageView,attribute:.bottom,multiplier:1,constant:-625).isActive=true
		NSLayoutConstraint(item:buttonMint,attribute:.right, relatedBy:.equal,toItem:backgroundImageView,attribute:.left,  multiplier:1,constant: 200).isActive=true
		NSLayoutConstraint(item:buttonMint,attribute:.bottom,relatedBy:.equal,toItem:backgroundImageView,attribute:.bottom,multiplier:1,constant:-475).isActive=true
	}
	
	var buttonCandy: UIButton!
	func buttonCandyAction(sender: UIButton!) { Util.nav("Onboarding") }
	func setCandyButton(color: UIColor) {
		buttonCandy = UIButton()
		buttonCandy.backgroundColor = color
		buttonCandy.setTitle("Onboarding", for: .normal)
		buttonCandy.addTarget(self, action: #selector(buttonCandyAction), for: .touchUpInside)
		buttonCandy.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(buttonCandy)
		
		NSLayoutConstraint(item:buttonCandy,attribute:.left,  relatedBy:.equal,toItem:backgroundImageView,attribute:.left,  multiplier:1,constant: 210).isActive=true
		NSLayoutConstraint(item:buttonCandy,attribute:.top,   relatedBy:.equal,toItem:backgroundImageView,attribute:.bottom,multiplier:1,constant:-150).isActive=true
		NSLayoutConstraint(item:buttonCandy,attribute:.right, relatedBy:.equal,toItem:backgroundImageView,attribute:.left,  multiplier:1,constant: 360).isActive=true
		NSLayoutConstraint(item:buttonCandy,attribute:.bottom,relatedBy:.equal,toItem:backgroundImageView,attribute:.bottom,multiplier:1,constant: -10).isActive=true
	}
	
	
	var buttonBlueberry: UIButton!
	func buttonBlueberryAction(sender: UIButton!) { Util.nav("Beacons") }
	func setBlueberryButton(color: UIColor) {
		buttonBlueberry = UIButton()
		buttonBlueberry.backgroundColor = color
		buttonBlueberry.setTitle("Beacons", for: .normal)
		buttonBlueberry.addTarget(self, action: #selector(buttonBlueberryAction), for: .touchUpInside)
		buttonBlueberry.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(buttonBlueberry)
		
		NSLayoutConstraint(item:buttonBlueberry,attribute:.left,  relatedBy:.equal,toItem:backgroundImageView,attribute:.left,  multiplier:1,constant: 210).isActive=true
		NSLayoutConstraint(item:buttonBlueberry,attribute:.top,   relatedBy:.equal,toItem:backgroundImageView,attribute:.bottom,multiplier:1,constant:-375).isActive=true
		NSLayoutConstraint(item:buttonBlueberry,attribute:.right, relatedBy:.equal,toItem:backgroundImageView,attribute:.left,  multiplier:1,constant: 360).isActive=true
		NSLayoutConstraint(item:buttonBlueberry,attribute:.bottom,relatedBy:.equal,toItem:backgroundImageView,attribute:.bottom,multiplier:1,constant:-225).isActive=true
	}
	
	var buttonBeetroot: UIButton!
	func buttonBeetrootAction(sender: UIButton!) { Util.nav("Map") }
	func setBeetrootButton(color: UIColor) {
		buttonBeetroot = UIButton()
		buttonBeetroot.backgroundColor = color
		buttonBeetroot.setTitle("Map", for: .normal)
		buttonBeetroot.addTarget(self, action: #selector(buttonBeetrootAction), for: .touchUpInside)
		buttonBeetroot.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(buttonBeetroot)
		
		NSLayoutConstraint(item:buttonBeetroot,attribute:.left,  relatedBy:.equal,toItem:backgroundImageView,attribute:.left,  multiplier:1,constant: 210).isActive=true
		NSLayoutConstraint(item:buttonBeetroot,attribute:.top,   relatedBy:.equal,toItem:backgroundImageView,attribute:.bottom,multiplier:1,constant:-625).isActive=true
		NSLayoutConstraint(item:buttonBeetroot,attribute:.right, relatedBy:.equal,toItem:backgroundImageView,attribute:.left,  multiplier:1,constant: 360).isActive=true
		NSLayoutConstraint(item:buttonBeetroot,attribute:.bottom,relatedBy:.equal,toItem:backgroundImageView,attribute:.bottom,multiplier:1,constant:-475).isActive=true
	}
	

	override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = Layout.mint
		setNavigationBar(title: "Home")
		setMenu()
		setBackgroundImage(image: "estimote01")
		let color = UIColor.clear
		//let color = UIColor.blue
		setIceButton(color: color)
		setLemonButton(color: color)
		setMintButton(color: color)
		setCandyButton(color: color)
		setBlueberryButton(color: color)
		setBeetrootButton(color: color)
	}

}




