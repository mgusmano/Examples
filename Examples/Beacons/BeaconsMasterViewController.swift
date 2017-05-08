import UIKit

// so we show master view first
extension BeaconsMasterViewController: UISplitViewControllerDelegate {
	func splitViewController(_ splitViewController: UISplitViewController,
	                         collapseSecondary secondaryViewController: UIViewController,
	                         onto primaryViewController: UIViewController) -> Bool {
		return true
	}
}

extension BeaconsMasterViewController {
	func do_table_refresh() {
		tableView.reloadData()
		let now = NSDate()
		let updateString = "Last Updated at " + self.dateFormatter.string(from: now as Date)
		let attributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 16)]
		refreshControl?.attributedTitle = NSAttributedString(string: updateString, attributes: attributes)
		if (refreshControl?.isRefreshing)! { refreshControl?.endRefreshing() }
		
		indicator.stopAnimating()
		indicator.hidesWhenStopped = true

		
	}
	func getDevices() {
		Device.getDevices() { Devices in
			self.Devices = Devices
			DispatchQueue.main.async(execute: {self.do_table_refresh()})
		}
	}
}

protocol BeaconsSelectionDelegate: class {
	func deviceSelected(_ newDevice: Device)
}




class BeaconsMasterViewController: UITableViewController {

	override func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let verticalIndicator = scrollView.subviews.last as? UIImageView
		verticalIndicator?.backgroundColor = Layout.lemon
	}
	
	@IBAction func Menu(_ sender: Any) { Util.nav("Menu")}
	var Devices:[Device] = [Device]()
	var dateFormatter = DateFormatter()

	
	var indicator = UIActivityIndicatorView()
	func setActivityIndicator(color: UIColor) {
		indicator = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width:40, height:40))
		indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
		indicator.center = self.view.center
		indicator.color = color
		indicator.backgroundColor = UIColor.clear
		self.view.addSubview(indicator)
		indicator.bringSubview(toFront: self.view)
	}
	
	func goBack() {
		Util.nav("Menu")
	}
	override func viewDidLoad() {
        super.viewDidLoad()

//		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//		self.navigationController?.navigationBar.shadowImage = UIImage()
//		self.navigationController?.navigationBar.isTranslucent = true
//		self.navigationController?.view.backgroundColor = UIColor.clear
		
		// in an extension
		//self.navigationController?.navigationBar.transparentNavigationBar()
		
		self.navigationController?.navigationBar.barTintColor = UIColor.black
		self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
		self.title = "My Beacons"
		
		
		let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(BeaconsMasterViewController.goBack))
		backButton.tintColor = UIColor.white
		navigationItem.leftBarButtonItem = backButton
		
		setActivityIndicator(color: UIColor.white)
		indicator.startAnimating()

		
		getDevices()
		tableView.register(BeaconsTableViewCell.classForCoder(), forCellReuseIdentifier: "Beacons")

		tableView.separatorStyle = .none
		tableView.backgroundColor = UIColor.black
		
		tableView.backgroundView = UIImageView(image: UIImage(named: "estimote01"))
		tableView.backgroundView?.alpha = 0.3
		tableView.backgroundView?.contentMode = .scaleAspectFill
		
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		let splitViewController = appDelegate.window!.rootViewController as! UISplitViewController
		splitViewController.delegate = self
		
		let leftNavController = splitViewController.viewControllers.first as! UINavigationController
		let masterViewController = leftNavController.topViewController as! BeaconsMasterViewController
		let rightNavController = splitViewController.viewControllers.last as! UINavigationController
		let detailViewController = rightNavController.topViewController as! BeaconsDetailViewController
		masterViewController.delegate = detailViewController 
		detailViewController.navigationItem.leftItemsSupplementBackButton = true
		detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
		
		// https://www.andrewcbancroft.com/2015/03/17/basics-of-pull-to-refresh-for-swift-developers/
		self.dateFormatter.dateStyle = DateFormatter.Style.short
		self.dateFormatter.timeStyle = DateFormatter.Style.long
		let attributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 12)]
		refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attributes)
		refreshControl?.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControlEvents.valueChanged)
    }

	func handleRefresh(_ refreshControl: UIRefreshControl) {
		getDevices()
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 140
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Devices.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: BeaconsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Beacons", for: indexPath) as! BeaconsTableViewCell

		cell.type.text = "type:\t\t" + Devices[indexPath.row].type
		cell.identifier.text = "id: " + Devices[indexPath.row].identifier
		cell.color.text = "name:\t" + Devices[indexPath.row].color
		cell.uuid.text = Devices[indexPath.row].uuid
		cell.major.text = String(Devices[indexPath.row].major)
		cell.minor.text = String(Devices[indexPath.row].major)
		cell.picturetext = Devices[indexPath.row].color
		return cell
	}

	var delegate: BeaconsSelectionDelegate?

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedDevice = self.Devices[indexPath.row]
		self.delegate?.deviceSelected(selectedDevice)
		if let detailViewController = self.delegate as? BeaconsDetailViewController {
			splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
		}
	}
	
	
}
