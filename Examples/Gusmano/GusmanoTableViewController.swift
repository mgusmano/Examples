import UIKit

class GusmanoTableViewController: UITableViewController {
	@IBAction func Menu(_ sender: Any) { Util.nav("Menu") }
	@IBOutlet var tableview: UITableView!
	var gusmanos:[Gusmano] = [Gusmano]()
	//var gusmanos:[Gusmano] = gusmanoData
	var dateFormatter = DateFormatter()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.register(GusmanoTableViewCell.classForCoder(), forCellReuseIdentifier: "gusmano")
		tableView.separatorStyle = .none

		tableView.backgroundColor = UIColor.clear
//		
//		tableView.backgroundView = UIImageView(image: UIImage(named: "estimote01"))
//		tableView.backgroundView?.alpha = 0.5
//		tableView.backgroundView?.contentMode = .scaleAspectFill
		
		//tableView.backgroundView = nil;
		//tableView.backgroundView?.backgroundColor = UIColor(red:0.22, green:0.73, blue:0.75, alpha:1.0)
		
		self.dateFormatter.dateStyle = DateFormatter.Style.short
		self.dateFormatter.timeStyle = DateFormatter.Style.long
		
		self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
		self.refreshControl?.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControlEvents.valueChanged)
		getGusmanos()
	}
	
	func handleRefresh(_ refreshControl: UIRefreshControl) {
		getGusmanos()
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 120
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return gusmanos.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: GusmanoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "gusmano", for: indexPath) as! GusmanoTableViewCell
		//let cell = GusmanoTableViewCell(style: .default, reuseIdentifier: "Cell")
		
		cell.fullname.text = "" + gusmanos[indexPath.row].firstname + " " + gusmanos[indexPath.row].lastname
		cell.title.text = "" + gusmanos[indexPath.row].title
		cell.email.text = "" + gusmanos[indexPath.row].email
		cell.phone.text = "" + gusmanos[indexPath.row].phone

		cell.picturetext = "" + gusmanos[indexPath.row].picture
		cell.labtime.text = DateFormatter.localizedString(from: NSDate() as Date, dateStyle:.short, timeStyle:.short)
		cell.backgroundColor = UIColor.clear
		cell.selectionStyle = .none
		return cell
	}
	
//	override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
//		let cell  = tableView.cellForRow(at: indexPath)
//		//cell?.setSelected(false, animated: true)
//		cell!.contentView.backgroundColor = .red
//	}
//	
//	override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
//		let cell  = tableView.cellForRow(at: indexPath)
//		//cell?.setSelected(true, animated: true)
//		cell!.contentView.backgroundColor = .clear
//	}
	
	
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//#eef0f2
		//let cell:GusmanoTableViewCell = tableView.cellForRow(at: indexPath) as! GusmanoTableViewCell
		
		
		//let cell  = tableView.cellForRow(at: indexPath)
		//cell!.contentView.backgroundColor = UIColor.red
		
		
//		if(cell!.isSelected){
//			cell!.contentView.backgroundColor = UIColor.clear
//		}else{
//			cell!.contentView.backgroundColor = UIColor.red
//		}
	}
	
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		let selectedDevice = self.devices[indexPath.row]
//		self.delegate?.deviceSelected(selectedDevice)
//		if let detailViewController = self.delegate as? CloudDetailViewController {
//			splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
//		}
//	}
	
	
}

extension GusmanoTableViewController {
	func do_table_refresh() {
		tableview.reloadData()
		
		let now = NSDate()
		let updateString = "Last Updated at " + self.dateFormatter.string(from: now as Date)
		refreshControl?.attributedTitle = NSAttributedString(string: updateString)
		if (refreshControl?.isRefreshing)!
		{
			refreshControl?.endRefreshing()
		}

	}
	
	func getGusmanos() {
		Gusmano.getGusmanos() { gusmanos in
			self.gusmanos = gusmanos
			DispatchQueue.main.async(execute: {self.do_table_refresh()})
		}
	}
}
