import UIKit

class MenuViewController: UIViewController {
	
	var menus:[Menu] = menuData
	
	@IBOutlet weak var ImageView: UIImageView!
	@IBOutlet weak var leadingConstraint: NSLayoutConstraint!
	@IBOutlet weak var trailingConstraint: NSLayoutConstraint!
	var menuShowing = false
	var menuWidth: CGFloat = 200

	func go(to: String) {
		leadingConstraint.constant = 0
		trailingConstraint.constant = 0
		menuShowing = false
		Util.nav(to)
	}
	
	

	@IBAction func toggleSideMenu(_ sender: Any) {
		if (menuShowing) {
			leadingConstraint.constant = 0
			trailingConstraint.constant = 0
		}
		else {
			leadingConstraint.constant = menuWidth
			trailingConstraint.constant = -menuWidth
		}
		UIView.animate(withDuration: 0.3,
			animations: {
				self.view.layoutIfNeeded()
		})
		menuShowing = !menuShowing
	}
	
	@IBOutlet var MenuView: UIView!
	@IBOutlet weak var MainView: UIView!
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()

//		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//		self.navigationController?.navigationBar.shadowImage = UIImage()
//		self.navigationController?.navigationBar.isTranslucent = true
//		self.navigationController?.view.backgroundColor = UIColor.clear
		
		self.navigationController?.navigationBar.barTintColor = UIColor.black
		self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
		
		let screenSize: CGRect = UIScreen.main.bounds
		let screenWidth = screenSize.width
		let screenHeight = screenSize.height
		
		MainView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight);
		ImageView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight);
		
		MainView.layer.shadowOpacity = 1
		MainView.layer.shadowRadius = 10
		

		tableView.frame = CGRect(x: 0, y: 30, width: menuWidth, height: screenHeight-30);
		
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	
	
	@IBAction func People(_ sender: Any) {
		Util.nav("People")
	}
	@IBAction func Web(_ sender: Any) {
		Util.nav("Web")
	}
	@IBAction func Map(_ sender: Any) { Util.nav("Map") }
	@IBAction func EstimoteCloud(_ sender: Any) { Util.nav("Beacons") }
	@IBAction func HotelCalifornia(_ sender: Any) { Util.nav("Login")}

	@IBAction func ResetOnboarding(_ sender: Any) {
		GeneralSettings.saveOnboardingNotFinished()
		Util.nav("Onboarding")
	}


}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return menus.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = menus[indexPath.row].title
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedItem = menus[indexPath.row].storyboard
		print(selectedItem)
		go(to: selectedItem)
		
		//		self.delegate?.deviceSelected(selectedDevice)
		//		if let detailViewController = self.delegate as? CloudDetailViewController {
		//			splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
		//		}
	}
}

