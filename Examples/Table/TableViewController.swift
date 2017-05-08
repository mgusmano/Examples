import UIKit

class TableViewController: UIViewController {
	var myTableView: UITableView  = UITableView()
	var itemsToLoad: [String] = ["One", "Two", "Three"]

	
	@IBAction func Menu(_ sender: Any) {
		Util.nav("Menu")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		let screenSize: CGRect = UIScreen.main.bounds
		let screenWidth = screenSize.width
		let screenHeight = screenSize.height
		
		myTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight);
		myTableView.dataSource = self
		myTableView.delegate = self
		
		//myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
		myTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
		self.view.addSubview(myTableView)
	}
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemsToLoad.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		//let cell:UITableViewCell  = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
		let cell:CustomTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
		cell.typeLabel?.text = self.itemsToLoad[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("User selected table row \(indexPath.row) and item \(itemsToLoad[indexPath.row])")
	}
	
	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
		let shareAction  = UITableViewRowAction(style: .normal, title: "Share") { (rowAction, indexPath) in
			print("Share Button tapped. Row item value = \(self.itemsToLoad[indexPath.row])")
			
			self.displayShareSheet(indexPath: indexPath)
		}
		let deleteAction  = UITableViewRowAction(style: .default, title: "Delete") { (rowAction, indexPath) in
			print("Delete Button tapped. Row item value = \(self.itemsToLoad[indexPath.row])")
		}
		shareAction.backgroundColor = UIColor.green
		return [shareAction,deleteAction]
	}
	
	func displayShareSheet(indexPath: IndexPath)
	{
		let alertController = UIAlertController(title: "Action Sheet", message: "What would you like to do?", preferredStyle: .actionSheet)
		
		let shareViaFacebook = UIAlertAction(title: "Share via Facebook", style: .default, handler: { (action) -> Void in
			print("Send now button tapped for value \(self.itemsToLoad[indexPath.row])")
		})
		
		let shareViaEmail = UIAlertAction(title: "Share via Email", style: .default, handler: { (action) -> Void in
			print("Delete button tapped for value \(self.itemsToLoad[indexPath.row])")
		})
		
		let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
			print("Cancel button tapped")
			self.myTableView.setEditing(false, animated: true)
		})
		
		alertController.addAction(shareViaFacebook)
		alertController.addAction(shareViaEmail)
		alertController.addAction(cancelButton)
		
		self.navigationController!.present(alertController, animated: true, completion: nil)
	}
	
	
	
	
	
	
}
