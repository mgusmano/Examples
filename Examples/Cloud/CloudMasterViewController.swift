//https://www.andrewcbancroft.com/2015/03/17/basics-of-pull-to-refresh-for-swift-developers/
import UIKit

protocol DeviceSelectionDelegate: class {
	func deviceSelected(_ newDevice: Device)
}

extension CloudMasterViewController: UISplitViewControllerDelegate {
	func splitViewController(_ splitViewController: UISplitViewController,
	                         collapseSecondary secondaryViewController: UIViewController,
	                         onto primaryViewController: UIViewController) -> Bool {
		return true
	}
}

extension CloudMasterViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return devices.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell", for: indexPath)  as! DeviceTableViewCell
		let device = devices[indexPath.row] as Device
		cell.device = device
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedDevice = self.devices[indexPath.row]
		self.delegate?.deviceSelected(selectedDevice)
		if let detailViewController = self.delegate as? CloudDetailViewController {
			splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
		}
	}
}

class CloudMasterViewController: UIViewController {


	lazy var refreshControl: UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControlEvents.valueChanged)
		return refreshControl
	}()
	
	func handleRefresh(_ refreshControl: UIRefreshControl) {
		// Do some reloading of data and update the table view's data source
		// Fetch more objects from a web service, for example...
		
		// Simply adding an object to the data source for this example
		//		let newMovie = Movie(title: "Serenity", genre: "Sci-fi")
		//		devices.append(newMovie)
		//
		//		movies.sort() { $0.title < $1.title }

		getDevices()
		
		
		
		//self.tableview.reloadData()
		//refreshControl.endRefreshing()
	}
	
	
	var delegate: DeviceSelectionDelegate?

	var roundButton = UIButton()
	func createNewButton(button: UIButton) {
		button.setTitleColor(UIColor.orange, for: .normal)
		button.alpha = 0.8
		button.setTitle("+", for: .normal)
		button.addTarget(self, action: #selector(ButtonClick(_:)), for: UIControlEvents.touchUpInside)
		view.addSubview(button)
	}
	
	@IBAction func Menu(_ sender: Any) { Util.nav("Menu") }
	@IBAction func ButtonClick(_ sender: UIButton){ print("Button tapped") }
	@IBOutlet weak var tableview: UITableView!
	
	var devices:[Device] = [Device]()
	//var devices:[Device] = deviceData

	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableview.addSubview(self.refreshControl)
		tableview.register(AnotherTableViewCell.self, forCellReuseIdentifier: "anotherCell")
		
		
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		let splitViewController = appDelegate.window!.rootViewController as! UISplitViewController
		splitViewController.delegate = self
			
		let leftNavController = splitViewController.viewControllers.first as! UINavigationController
		let masterViewController = leftNavController.topViewController as! CloudMasterViewController
			
		let rightNavController = splitViewController.viewControllers.last as! UINavigationController
		let detailViewController = rightNavController.topViewController as! CloudDetailViewController
			
		masterViewController.delegate = detailViewController  //as! DeviceSelectionDelegate
			
		detailViewController.navigationItem.leftItemsSupplementBackButton = true
		detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
			
		createNewButton(button: roundButton)
		getDevices()
	}

	override func viewWillLayoutSubviews() {
		//
		//        NSLayoutConstraint.activate([
		//            //tableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
		//            //tableview.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
		//            //tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
		//            //tableview.topAnchor.constraint(equalTo: 0),
		//            //tableview.widthAnchor.constraint(equalToConstant: 50),
		//            //tableview.heightAnchor.constraint(equalToConstant: 400)
		//				])
		roundButton.layer.cornerRadius = roundButton.layer.frame.size.width/2
		roundButton.backgroundColor = UIColor.lightGray
		roundButton.clipsToBounds = true
		//roundButton.setImage(UIImage(named:"1Stars"), for: .normal)
		roundButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			roundButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -53),
			roundButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -53),
			roundButton.widthAnchor.constraint(equalToConstant: 50),
			roundButton.heightAnchor.constraint(equalToConstant: 50)
			])
	}
}

extension CloudMasterViewController {
	func do_table_refresh() {
		tableview.reloadData()
		refreshControl.endRefreshing()
	}
	
	func getDevices() {
		Device.getDevices() { devices in
			self.devices = devices
			DispatchQueue.main.async(execute: {self.do_table_refresh()})
		}
	}
}



//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//		if (indexPath.row == 1) {
//			var cell: AnotherTableViewCell
//			cell = tableView.dequeueReusableCell(withIdentifier: "anotherCell", for: indexPath)  as! AnotherTableViewCell
//			//		let cell = tableView.dequeueReusableCell(withIdentifier: "anotherCell", for: indexPath)  as! AnotherTableViewCell
//			let device = devices[indexPath.row] as Device
//			cell.colorLabel.text = device.color
//			return cell
//		}
//		else {
//			var cell: DeviceTableViewCell
//			cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell", for: indexPath)  as! DeviceTableViewCell
//			//		let cell = tableView.dequeueReusableCell(withIdentifier: "anotherCell", for: indexPath)  as! AnotherTableViewCell
//			let device = devices[indexPath.row] as Device
//			cell.device = device
//			return cell
//		}
//
//	}

//	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//		let x = tableview.bounds.midX
//		let y = tableview.bounds.midY
//		let top = CGPoint(x:x, y:y)
//		let pathForCenterCell = tableview.indexPathForRow(at: top)
//		tableview.scrollToRow(at: pathForCenterCell!, at: UITableViewScrollPosition.middle, animated: true)
//	}

//	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//		let screenSize: CGRect = UIScreen.main.bounds
//		let screenHeight = screenSize.height
//		let cellHeight = screenHeight
//		let y          = targetContentOffset.pointee.y + scrollView.contentInset.top + (cellHeight / 2)
//		let cellIndex  = floor(y / cellHeight)
//		targetContentOffset.pointee.y = cellIndex * cellHeight - scrollView.contentInset.top
//	}

//	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//		let screenSize: CGRect = UIScreen.main.bounds
//		let screenHeight = screenSize.height
//		return screenHeight;
//	}




//var TableData:Array<String> = ["1","2"]
//return TableData.count
//cell.textLabel?.text = TableData[indexPath.row]


//	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.alpha = 0
//        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
//        cell.layer.transform = transform
//
//        UIView.animate(withDuration: 0.5, animations: {
//            cell.alpha = 1.0
//            cell.layer.transform = CATransform3DIdentity
//        })
//	}
