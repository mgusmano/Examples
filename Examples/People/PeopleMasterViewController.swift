import UIKit

// so we show master view first
extension PeopleMasterViewController: UISplitViewControllerDelegate {
	func splitViewController(_ splitViewController: UISplitViewController,
	                         collapseSecondary secondaryViewController: UIViewController,
	                         onto primaryViewController: UIViewController) -> Bool {
		return true
	}
}

extension PeopleMasterViewController {
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
	func getPeople() {
		Person.getPeople() { People in
			self.People = People
			DispatchQueue.main.async(execute: {self.do_table_refresh()})
		}
	}
}

protocol PeopleSelectionDelegate: class {
	func deviceSelected(_ newDevice: Person)
}

class PeopleMasterViewController: UITableViewController {

	override func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let verticalIndicator = scrollView.subviews.last as? UIImageView
		verticalIndicator?.backgroundColor = Layout.lemon
	}
	
	@IBAction func Menu(_ sender: Any) { Util.nav("Menu")}
	var People:[Person] = [Person]()
	var dateFormatter = DateFormatter()

	// https://grokswift.com/transparent-table-view/
	override func viewWillAppear(_ animated: Bool) {
		self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
		super.viewWillAppear(animated)
		
		
		//backgroundColor = UIColor.clear
		
		// Add a background view to the table view
		//let backgroundImage = UIImage(named: "GrokSwiftLogo500.png")
		//let imageView = UIImageView(image: backgroundImage)
		//self.tableView.backgroundView = imageView

		tableView.separatorStyle = .none
		tableView.backgroundColor = Layout.mint
		//tableView.backgroundView = UIImageView(image: UIImage(named: "estimote01"))
		//tableView.backgroundView?.alpha = 0.4
		//tableView.backgroundView?.contentMode = .scaleAspectFill
		
		tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
	}

	var indicator = UIActivityIndicatorView()
	func activityIndicator() {
		indicator = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width:40, height:40))
		indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
		indicator.center = self.view.center
		self.view.addSubview(indicator)
		indicator.bringSubview(toFront: self.view)
	}
	
	func goBack() {
		Util.nav("Menu")
	}
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

		//self.navigationController
		
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationController?.navigationBar.isTranslucent = true
		self.navigationController?.view.backgroundColor = UIColor.clear
		
		
//		navigationController?.navigationBar.backgroundColor = UIColor.clear
//		self.navigationController?.navigationBar.alpha = 0.0
//		self.navigationController?.navigationBar.isTranslucent = true
		
		let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: "goBack")
		navigationItem.leftBarButtonItem = backButton

		
		//self.navigationController?.navigationBar.
		
		//navigationController?.navigationBar.extendedLayoutIncludesOpaqueBars = true
		//navigationBar.isTranslucent = true
		//print(navigationController?.navigationBar.backgroundColor)
		//navigationBar.backgroundColor = UIColor.clear
		//navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
		//navigationController?.navigationBar.shadowImage = UIImage()
		
		//edgesForExtendedLayout = []
		
		
		
//		let headerView = UIView()
//		headerView.backgroundColor = UIColor.blue
//		headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
//		tableView.tableHeaderView = headerView
		
		
		activityIndicator()
		indicator.startAnimating()
		//indicator.backgroundColor = UIColor.white
		
		getPeople()
		tableView.register(PeopleTableViewCell.classForCoder(), forCellReuseIdentifier: "Person")
		
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		let splitViewController = appDelegate.window!.rootViewController as! UISplitViewController
		splitViewController.delegate = self
		
		let leftNavController = splitViewController.viewControllers.first as! UINavigationController
		let masterViewController = leftNavController.topViewController as! PeopleMasterViewController
		let rightNavController = splitViewController.viewControllers.last as! UINavigationController
		let detailViewController = rightNavController.topViewController as! PeopleDetailViewController
		masterViewController.delegate = detailViewController  //as! PeopleSelectionDelegate
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
		getPeople()
	}

//	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//		
//		var headerView: PeopleTableViewCellHeader = tableView.dequeueReusableCell(withIdentifier: "SectionHeader")  as! PeopleTableViewCellHeader
//		if (headerView == nil) {
//			headerView = PeopleTableViewCellHeader(style:UITableViewCellStyle.subtitle, reuseIdentifier:"SectionHeader")
//		}
//			headerView.textLabel!.text = "Hello World"
//		return headerView;
//	}
	
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 120
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return People.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: PeopleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Person", for: indexPath) as! PeopleTableViewCell
		
		cell.fullname.text = "" + People[indexPath.row].firstname + " " + People[indexPath.row].lastname
		cell.title.text = "" + People[indexPath.row].title
		cell.email.text = "" + People[indexPath.row].email
		cell.phone.text = "" + People[indexPath.row].phone
		cell.picturetext = "" + People[indexPath.row].picture
		cell.labtime.text = DateFormatter.localizedString(from: NSDate() as Date, dateStyle:.short, timeStyle:.short)
		return cell
	}

	var delegate: PeopleSelectionDelegate?

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedDevice = self.People[indexPath.row]
		self.delegate?.deviceSelected(selectedDevice)
		if let detailViewController = self.delegate as? PeopleDetailViewController {
			splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
		}
	}
	
	
}
